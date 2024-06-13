import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
  bool _isCafeButtonPressed = false;
  bool _isStoreButtonPressed = false;
  LatLng? _currentCameraPosition;

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

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _currentCameraPosition = position.target;
    });
  }

  Future<BitmapDescriptor> _getRestaurantMarkerIcon() async {
    final ByteData data = await NetworkAssetBundle(Uri.parse(
            'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/marker/restaurant_marker_mid.png'))
        .load('');
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    final Uint8List bytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(bytes);
  }

  Future<BitmapDescriptor> _getCafeMarkerIcon() async {
    final ByteData data = await NetworkAssetBundle(Uri.parse(
            'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/marker/cafe_marker_mid.png'))
        .load('');
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    final Uint8List bytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(bytes);
  }

  Future<BitmapDescriptor> _getStoreMarkerIcon() async {
    final ByteData data = await NetworkAssetBundle(Uri.parse(
            'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/marker/store_marker_mid.png'))
        .load('');
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    final Uint8List bytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(bytes);
  }

  void _toggleRestaurantMarkers() async {
    if (_isRestaurantButtonPressed) {
      setState(() {
        _markers.removeWhere(
            (marker) => marker.markerId.value.startsWith('restaurant_'));
        _isRestaurantButtonPressed = false;
      });
    } else {
      if (_currentCameraPosition != null) {
        final restaurants = await ApiService.getRestaurant(
          _currentCameraPosition!.latitude.toString(),
          _currentCameraPosition!.longitude.toString(),
        );

        final restaurantMarkerIcon = await _getRestaurantMarkerIcon();

        final restaurantMarkers = restaurants.map((restaurant) {
          return Marker(
            markerId: MarkerId('restaurant_${restaurant.name}'),
            position: LatLng(restaurant.latitude, restaurant.longitude),
            icon: restaurantMarkerIcon,
            infoWindow: InfoWindow(
              title: restaurant.name,
              snippet: '평점: ${restaurant.rating}',
              onTap: () async {
                if (await canLaunchUrl(
                    Uri.parse(restaurant.google_maps_link))) {
                  await launchUrl(Uri.parse(restaurant.google_maps_link));
                } else {
                  throw 'Could not launch ${restaurant.google_maps_link}';
                }
              },
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
  }

  void _toggleCafeMarkers() async {
    if (_isCafeButtonPressed) {
      setState(() {
        _markers
            .removeWhere((marker) => marker.markerId.value.startsWith('cafe_'));
        _isCafeButtonPressed = false;
      });
    } else {
      if (_currentCameraPosition != null) {
        final cafes = await ApiService.getCafe(
          _currentCameraPosition!.latitude.toString(),
          _currentCameraPosition!.longitude.toString(),
        );

        final cafeMarkerIcon = await _getCafeMarkerIcon();

        final cafeMarkers = cafes.map((cafe) {
          return Marker(
            markerId: MarkerId('cafe_${cafe.name}'),
            position: LatLng(cafe.latitude, cafe.longitude),
            icon: cafeMarkerIcon,
            infoWindow: InfoWindow(
              title: cafe.name,
              snippet: '평점: ${cafe.rating}',
            ),
            onTap: () {
              _mapController
                  ?.showMarkerInfoWindow(MarkerId('cafe_${cafe.name}'));
            },
          );
        }).toSet();

        setState(() {
          _markers.addAll(cafeMarkers);
          _isCafeButtonPressed = true;
        });
      }
    }
  }

  void _toggleStoreMarkers() async {
    if (_isStoreButtonPressed) {
      setState(() {
        _markers.removeWhere(
            (marker) => marker.markerId.value.startsWith('store_'));
        _isStoreButtonPressed = false;
      });
    } else {
      if (_currentCameraPosition != null) {
        final stores = await ApiService.getStore(
          _currentCameraPosition!.latitude.toString(),
          _currentCameraPosition!.longitude.toString(),
        );

        final storeMarkerIcon = await _getStoreMarkerIcon();

        final storeMarkers = stores.map((store) {
          return Marker(
            markerId: MarkerId('store_${store.name}'),
            position: LatLng(store.latitude, store.longitude),
            icon: storeMarkerIcon,
            infoWindow: InfoWindow(
              title: store.name,
              snippet: '평점: ${store.rating}',
              onTap: () async {
                if (await canLaunchUrl(Uri.parse(store.google_maps_link))) {
                  await launchUrl(Uri.parse(store.google_maps_link));
                } else {
                  throw 'Could not launch ${store.google_maps_link}';
                }
              },
            ),
            onTap: () {
              _mapController
                  ?.showMarkerInfoWindow(MarkerId('store_${store.name}'));
            },
          );
        }).toSet();

        setState(() {
          _markers.addAll(storeMarkers);
          _isStoreButtonPressed = true;
        });
      }
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
                  onCameraMove: _onCameraMove,
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
                            bottom: 20,
                            right: 50,
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
                              child: SizedBox(
                                width: 75, // 텍스트의 최대 너비 지정
                                child: Text(
                                  widget.pname,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true, // 줄바꿈 설정
                                  overflow: TextOverflow
                                      .visible, // 오버플로우되는 부분은 줄임표로 표시
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
                          Positioned(
                            right: 10,
                            top: 110,
                            child: ElevatedButton(
                              onPressed: _toggleCafeMarkers,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                backgroundColor: _isCafeButtonPressed
                                    ? Colors.blue
                                    : Colors.white,
                                foregroundColor: _isCafeButtonPressed
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.local_cafe, size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    '카페',
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
                          Positioned(
                            right: 10,
                            top: 160,
                            child: ElevatedButton(
                              onPressed: _toggleStoreMarkers,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                backgroundColor: _isStoreButtonPressed
                                    ? Colors.blue
                                    : Colors.white,
                                foregroundColor: _isStoreButtonPressed
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.store, size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    '편의점',
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
                    return Container();
                  },
                ),
              ],
            ),
    );
  }
}
