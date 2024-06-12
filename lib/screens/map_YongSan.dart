import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class Map_YongSan extends StatefulWidget {
  const Map_YongSan({super.key});

  @override
  _Map_YongSanState createState() => _Map_YongSanState();
}

class _Map_YongSanState extends State<Map_YongSan> {
  NaverMapController? _mapController;
  final NLatLng _initialCameraPosition =
      const NLatLng(37.5300090111487, 126.969510593878);

  // 지도 초기화하기
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
            target: const NLatLng(37.5344018722304, 126.973359125512),
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
        body: FutureBuilder(
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
                  ButtonLayer(onButtonPressed: _handleButtonPressed),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class ButtonLayer extends StatefulWidget {
  final Function(int) onButtonPressed;

  const ButtonLayer({super.key, required this.onButtonPressed});

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: _visibleButtonIndex == 0 ? (screenHeight - 56) / 2 : 410,
          left: _visibleButtonIndex == 0 ? (screenWidth - 56) / 2 : 41,
          child: AnimatedOpacity(
            opacity: _visibleButtonIndex == 0 || _visibleButtonIndex == -1
                ? 1.0
                : 0.0,
            duration: const Duration(milliseconds: 200),
            child: ElevatedButton(
              onPressed: () => _toggleButton(0),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(28),
                backgroundColor: Colors.red,
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
        Positioned(
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
                backgroundColor: Colors.red,
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
        ),
        Positioned(
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
                backgroundColor: Colors.red,
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
        ),
      ],
    );
  }
}
