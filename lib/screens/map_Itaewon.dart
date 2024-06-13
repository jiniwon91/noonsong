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

class Map_Itaewon extends StatefulWidget {
  const Map_Itaewon({super.key});

  @override
  _Map_ItaewonState createState() => _Map_ItaewonState();
}

class _Map_ItaewonState extends State<Map_Itaewon> {
  final LatLng _initialCameraPosition =
      const LatLng(37.533368436605, 126.994919788288);
  Future<MapModel>? _itaewonStationData;
  Future<MapModel>? _itaewonTourismData;
  Future<MapModel>? _itaewonFurnitureData;
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
    _itaewonStationData = ApiService.fetchDatafromAPI('이태원역');
    await _itaewonStationData;
    _itaewonTourismData = ApiService.fetchDatafromAPI('이태원 관광특구');
    await _itaewonTourismData;
    _itaewonFurnitureData = ApiService.fetchDatafromAPI('이태원 앤틱가구거리');
    await _itaewonFurnitureData;

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
        position = const LatLng(37.534483277545, 126.993721655506);
        zoom = 18;
        pname = '이태원역';
        break;
      case 1:
        position = const LatLng(37.534259668739, 126.996325056339);
        zoom = 18;
        pname = '이태원 관광특구';
        break;
      case 2:
        position = const LatLng(37.5323006192162, 126.99404281204);
        zoom = 18;
        pname = '이태원 앤틱가구거리';
        break;
      default:
        position = _initialCameraPosition;
        zoom = 15.5;
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
                        zoom: 15.5,
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
                    itaewonStationData: _itaewonStationData,
                    itaewonTourismData: _itaewonTourismData,
                    itaewonFurnitureData: _itaewonFurnitureData,
                  ),
                ],
              ),
      ),
    );
  }
}

class ButtonLayer extends StatelessWidget {
  final Function(int) onButtonPressed;
  final Future<MapModel>? itaewonStationData;
  final Future<MapModel>? itaewonTourismData;
  final Future<MapModel>? itaewonFurnitureData;

  const ButtonLayer({
    super.key,
    required this.onButtonPressed,
    required this.itaewonStationData,
    required this.itaewonTourismData,
    required this.itaewonFurnitureData,
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
          future: itaewonStationData,
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
                  top: 335,
                  left: 130,
                  child: ElevatedButton(
                    onPressed: () => onButtonPressed(0),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(28),
                      backgroundColor: buttoncolor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      '이태원역',
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
          future: itaewonTourismData,
          builder: (context, snapshot) {
            final buttoncolor = snapshot.hasData
                ? _getButtonColor(snapshot.data!.CONGEST_LVL)
                : Colors.grey;
            return Positioned(
              top: 350,
              right: 50,
              child: ElevatedButton(
                onPressed: () => onButtonPressed(1),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(28),
                  backgroundColor: buttoncolor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  '이태원 관광\n특구',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
        FutureBuilder<MapModel>(
          future: itaewonFurnitureData,
          builder: (context, snapshot) {
            final buttoncolor = snapshot.hasData
                ? _getButtonColor(snapshot.data!.CONGEST_LVL)
                : Colors.grey;
            return Positioned(
              top: 450,
              left: 100,
              child: ElevatedButton(
                onPressed: () => onButtonPressed(2),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(28),
                  backgroundColor: buttoncolor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  '이태원 앤틱\n가구거리',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
