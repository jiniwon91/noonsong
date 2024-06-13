import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nunsong/widgets/population_complexity.dart';
import 'package:nunsong/widgets/weather_widget.dart';
import 'package:nunsong/services/api_service.dart';
import 'package:nunsong/services/map_api.dart';

class EnlargedMapScreen extends StatefulWidget {
  final LatLng initialPosition;
  final double zoom;
  final String pname;

  const EnlargedMapScreen({
    super.key,
    required this.initialPosition,
    required this.zoom,
    required this.pname,
  });

  @override
  _EnlargedMapScreenState createState() => _EnlargedMapScreenState();
}

class _EnlargedMapScreenState extends State<EnlargedMapScreen> {
  Future<MapModel>? _mapData;
  late Timer _timer;
  bool _isLoading = true;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  bool _isRestaurantButtonPressed = false;

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
    _mapData = ApiService.fetchDatafromAPI(widget.pname);
    await _mapData;
    setState(() {
      _isLoading = false;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _fetchData();
    });
  }

  void _toggleRestaurantMarkers() async {
    if (_isRestaurantButtonPressed) {
      setState(() {
        _markers.removeWhere(
            (marker) => marker.markerId.value.startsWith('restaurant_'));
        _isRestaurantButtonPressed = false;
      });
    } else {
      final restaurants = await ApiService.getRestaurant(
        widget.initialPosition.latitude.toString(),
        widget.initialPosition.longitude.toString(),
      );

      final restaurantMarkers = restaurants.map((restaurant) {
        return Marker(
          markerId: MarkerId('restaurant_${restaurant.name}'),
          position: LatLng(restaurant.latitude, restaurant.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: restaurant.name,
          ),
          onTap: () {
            _mapController?.showMarkerInfoWindow(
                MarkerId('restaurant_${restaurant.name}'));
          },
        );
      }).toSet();

      setState(() {
        _markers.addAll(restaurantMarkers);
        _isRestaurantButtonPressed = true;
      });
    }
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
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: widget.initialPosition,
                    zoom: widget.zoom,
                  ),
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                ),
                FutureBuilder<MapModel>(
                  future: _mapData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final ppltnTime = snapshot.data!.PPLTN_TIME;
                      final temp = snapshot.data!.TEMP;
                      final skystts = snapshot.data!.SKY_STTS;
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
                            top: MediaQuery.of(context).size.height / 2 - 28,
                            left: MediaQuery.of(context).size.width / 2 - 28,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(28),
                                backgroundColor: buttoncolor,
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                widget.pname,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 60,
                            child: ElevatedButton(
                              onPressed: _toggleRestaurantMarkers,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                backgroundColor: _isRestaurantButtonPressed
                                    ? Colors.blue
                                    : Colors.white,
                                foregroundColor: _isRestaurantButtonPressed
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.restaurant, size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    '음식점',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    // 데이터 로딩 중인 경우 빈 컨테이너 반환
                    return Container();
                  },
                ),
              ],
            ),
    );
  }
}
