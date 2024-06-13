import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:nunsong/widgets/population_complexity.dart';
import 'package:nunsong/widgets/weather_widget.dart';
import 'package:nunsong/services/api_service.dart';
import 'package:nunsong/services/map_api.dart';

class Map_YongSan extends StatefulWidget {
  const Map_YongSan({super.key});

  @override
  _Map_YongSanState createState() => _Map_YongSanState();
}

class _Map_YongSanState extends State<Map_YongSan> {
  NaverMapController? _mapController;
  final NLatLng _initialCameraPosition =
      const NLatLng(37.5300090111487, 126.969510593878);
  Future<MapModel>? _yongsanStationData;
  Future<MapModel>? _yongStreetData;
  Future<MapModel>? _samgakjiStationData;
  late Timer _timer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    _yongsanStationData = ApiService.fetchDatafromAPI('용산역');
    await _yongsanStationData;
    _yongStreetData = ApiService.fetchDatafromAPI('용리단길');
    await _yongStreetData;
    _samgakjiStationData = ApiService.fetchDatafromAPI('삼각지역');
    await _samgakjiStationData;

    setState(() {
      _isLoading = false;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _fetchData();
    });
  }

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await NaverMapSdk.instance.initialize(
        clientId: 'dnaa6kdl4e',
        onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
  }

  void _handleButtonPressed(int index) {
    if (_mapController != null) {
      NCameraUpdate cameraUpdate;
      switch (index) {
        case 0:
          cameraUpdate = NCameraUpdate.withParams(
            target: const NLatLng(37.5297718014452, 126.964741503485),
            zoom: 16.5,
          );
          break;
        case 1:
          cameraUpdate = NCameraUpdate.withParams(
            target: const NLatLng(37.5310724832954, 126.971391734373),
            zoom: 16.5,
          );
          break;
        case 2:
          cameraUpdate = NCameraUpdate.withParams(
            target: const NLatLng(37.5344158722304, 126.972759125512),
            zoom: 16.5,
          );
          break;
        default:
          cameraUpdate = NCameraUpdate.withParams(
            target: _initialCameraPosition,
            zoom: 14,
          );
      }
      cameraUpdate.setAnimation(
          animation: NCameraAnimation.fly,
          duration: const Duration(seconds: 1));
      _mapController!.updateCamera(cameraUpdate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: initialize(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Stack(
                      children: [
                        NaverMap(
                          options: NaverMapViewOptions(
                            indoorEnable: false,
                            locationButtonEnable: false,
                            consumeSymbolTapEvents: true,
                            initialCameraPosition: NCameraPosition(
                                target: _initialCameraPosition, zoom: 14),
                          ),
                          onMapReady: (controller) {
                            log("onMapReady", name: "onMapReady");
                            _mapController = controller;
                          },
                        ),
                        ButtonLayer(
                          onButtonPressed: _handleButtonPressed,
                          yongsanStationData: _yongsanStationData,
                          yongStreetData: _yongStreetData,
                          samgakjiStationData: _samgakjiStationData,
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}

class ButtonLayer extends StatefulWidget {
  final Function(int) onButtonPressed;
  final Future<MapModel>? yongsanStationData;
  final Future<MapModel>? yongStreetData;
  final Future<MapModel>? samgakjiStationData;

  const ButtonLayer({
    super.key,
    required this.onButtonPressed,
    required this.yongsanStationData,
    required this.yongStreetData,
    required this.samgakjiStationData,
  });

  @override
  _ButtonLayerState createState() => _ButtonLayerState();
}

class _ButtonLayerState extends State<ButtonLayer> {
  int _visibleButtonIndex = -1;

  void _toggleButton(int index) {
    setState(() {
      if (_visibleButtonIndex == index) {
        _visibleButtonIndex = -1;
        widget.onButtonPressed(-1);
      } else {
        _visibleButtonIndex = index;
        widget.onButtonPressed(index);
      }
    });
  }

  Color _getButtonColor(String congestLevel) {
    switch (congestLevel) {
      case '여유':
        return const Color(0xff00ba71);
      case '보통':
        return const Color(0xffFFD600);
      case '약간 붐빔':
        return const Color(0xffFF8901);
      case '붐빔':
        return const Color(0xffF43545);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        FutureBuilder<MapModel>(
          future: widget.yongsanStationData,
          builder: (context, snapshot) {
            final ppltnTime = snapshot.hasData ? snapshot.data!.PPLTN_TIME : '';
            final temp = snapshot.hasData ? snapshot.data!.TEMP : 0.0;
            final skystts = snapshot.hasData ? snapshot.data!.SKY_STTS : '';
            final buttoncolor = snapshot.hasData
                ? _getButtonColor(snapshot.data!.CONGEST_LVL)
                : Colors.grey;
            return Stack(
              children: [
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: population_complexity(ppltnTime: ppltnTime),
                ),
                Positioned(
                  left: 10,
                  top: 60,
                  child: WeatherWidget(TEMP: temp, SKY_STTS: skystts),
                ),
                Positioned(
                  top: _visibleButtonIndex == 0 ? (screenHeight - 56) / 2 : 410,
                  left: _visibleButtonIndex == 0 ? (screenWidth - 56) / 2 : 41,
                  child: AnimatedOpacity(
                    opacity:
                        _visibleButtonIndex == 0 || _visibleButtonIndex == -1
                            ? 1.0
                            : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: ElevatedButton(
                      onPressed: () => _toggleButton(0),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(28),
                        backgroundColor: buttoncolor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        '용산역',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        FutureBuilder<MapModel>(
          future: widget.yongStreetData,
          builder: (context, snapshot) {
            final buttoncolor = snapshot.hasData
                ? _getButtonColor(snapshot.data!.CONGEST_LVL)
                : Colors.grey;
            return Positioned(
              top: _visibleButtonIndex == 1 ? (screenHeight - 56) / 2 : 355,
              left: _visibleButtonIndex == 1 ? (screenWidth - 56) / 2 : 190,
              child: AnimatedOpacity(
                opacity: _visibleButtonIndex == 1 || _visibleButtonIndex == -1
                    ? 1.0
                    : 0.0,
                duration: const Duration(milliseconds: 200),
                child: ElevatedButton(
                  onPressed: () => _toggleButton(1),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(28),
                    backgroundColor: buttoncolor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    '용리단길',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        FutureBuilder<MapModel>(
          future: widget.samgakjiStationData,
          builder: (context, snapshot) {
            final buttoncolor = snapshot.hasData
                ? _getButtonColor(snapshot.data!.CONGEST_LVL)
                : Colors.grey;
            return Positioned(
              top: _visibleButtonIndex == 2 ? (screenHeight - 56) / 2 : 245,
              left: _visibleButtonIndex == 2 ? (screenWidth - 56) / 2 : 247,
              child: AnimatedOpacity(
                opacity: _visibleButtonIndex == 2 || _visibleButtonIndex == -1
                    ? 1.0
                    : 0.0,
                duration: const Duration(milliseconds: 200),
                child: ElevatedButton(
                  onPressed: () => _toggleButton(2),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(28),
                    backgroundColor: buttoncolor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    '삼각지역',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
