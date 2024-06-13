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

class Map_HangangPark extends StatefulWidget {
  const Map_HangangPark({super.key});

  @override
  _Map_HangangParkState createState() => _Map_HangangParkState();
}

class _Map_HangangParkState extends State<Map_HangangPark> {
  final LatLng _initialCameraPosition =
      const LatLng(37.517820588578, 126.970850893942);
  Future<MapModel>? _hangangParkData;
  Future<MapModel>? _nodleIslandData;
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
    _hangangParkData = ApiService.fetchDatafromAPI('이촌한강공원');
    await _hangangParkData;
    _nodleIslandData = ApiService.fetchDatafromAPI('노들섬');
    await _nodleIslandData;

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
        position = const LatLng(37.517820588578, 126.970850893942);
        zoom = 18;
        pname = '이촌한강공원';
        break;
      case 1:
        position = const LatLng(37.5176638307111, 126.958036465507);
        zoom = 18;
        pname = '노들섬';
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
                    hangangParkData: _hangangParkData,
                    nodleIslandData: _nodleIslandData,
                  ),
                ],
              ),
      ),
    );
  }
}

class ButtonLayer extends StatelessWidget {
  final Function(int) onButtonPressed;
  final Future<MapModel>? hangangParkData;
  final Future<MapModel>? nodleIslandData;

  const ButtonLayer({
    super.key,
    required this.onButtonPressed,
    required this.hangangParkData,
    required this.nodleIslandData,
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
          future: hangangParkData,
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
                    onPressed: () => onButtonPressed(1),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(28),
                      backgroundColor: buttoncolor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      '노들섬',
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
          future: nodleIslandData,
          builder: (context, snapshot) {
            final buttoncolor = snapshot.hasData
                ? _getButtonColor(snapshot.data!.CONGEST_LVL)
                : Colors.grey;
            return Positioned(
              top: 355,
              left: 190,
              child: ElevatedButton(
                onPressed: () => onButtonPressed(0),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(28),
                  backgroundColor: buttoncolor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  '이촌한강공원',
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
