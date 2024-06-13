import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nunsong/widgets/population_complexity.dart';
import 'package:nunsong/widgets/weather_widget.dart';
import 'package:nunsong/services/api_service.dart';
import 'package:nunsong/services/map_api.dart';
import 'package:nunsong/screens/enlarged_map_YongSan.dart';

class Map_YongSan extends StatefulWidget {
  const Map_YongSan({super.key});

  @override
  _Map_YongSanState createState() => _Map_YongSanState();
}

class _Map_YongSanState extends State<Map_YongSan> {
  final LatLng _initialCameraPosition =
      const LatLng(37.5300090111487, 126.969510593878);
  Future<MapModel>? _yongsanStationData;
  Future<MapModel>? _yongStreetData;
  Future<MapModel>? _samgakjiStationData;
  late Timer _timer;
  bool _isLoading = true;
  final Completer<GoogleMapController> _controller = Completer();

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

  void _handleButtonPressed(int index) {
    LatLng position;
    double zoom;
    String pname;

    switch (index) {
      case 0:
        position = const LatLng(37.5297718014452, 126.964741503485);
        zoom = 18;
        pname = '용산역';
        break;
      case 1:
        position = const LatLng(37.5310724832954, 126.971391734373);
        zoom = 18;
        pname = '용리단길';
        break;
      case 2:
        position = const LatLng(37.5344158722304, 126.972659125512);
        zoom = 18;
        pname = '삼각지역';
        break;
      default:
        position = _initialCameraPosition;
        zoom = 14;
        pname = '';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnlargedMapScreen(
          initialPosition: position,
          zoom: zoom,
          pname: pname,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  AbsorbPointer(
                    absorbing: true,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: _initialCameraPosition,
                        zoom: 14,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      gestureRecognizers: <Factory<
                          OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                    ),
                  ),
                  ButtonLayer(
                    onButtonPressed: _handleButtonPressed,
                    yongsanStationData: _yongsanStationData,
                    yongStreetData: _yongStreetData,
                    samgakjiStationData: _samgakjiStationData,
                  ),
                ],
              ),
      ),
    );
  }
}

class ButtonLayer extends StatelessWidget {
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
    return Stack(
      children: [
        FutureBuilder<MapModel>(
          future: yongsanStationData,
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
                  top: 410,
                  left: 41,
                  child: ElevatedButton(
                    onPressed: () => onButtonPressed(0),
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
              ],
            );
          },
        ),
        FutureBuilder<MapModel>(
          future: yongStreetData,
          builder: (context, snapshot) {
            final buttoncolor = snapshot.hasData
                ? _getButtonColor(snapshot.data!.CONGEST_LVL)
                : Colors.grey;
            return Positioned(
              top: 355,
              left: 190,
              child: ElevatedButton(
                onPressed: () => onButtonPressed(1),
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
            );
          },
        ),
        FutureBuilder<MapModel>(
          future: samgakjiStationData,
          builder: (context, snapshot) {
            final buttoncolor = snapshot.hasData
                ? _getButtonColor(snapshot.data!.CONGEST_LVL)
                : Colors.grey;
            return Positioned(
              top: 245,
              left: 247,
              child: ElevatedButton(
                onPressed: () => onButtonPressed(2),
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
            );
          },
        ),
      ],
    );
  }
}
