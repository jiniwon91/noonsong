import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class Map_YongSan extends StatelessWidget {
  const Map_YongSan({super.key});

  // 지도 초기화하기
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await NaverMapSdk.instance.initialize(
        clientId: 'dnaa6kdl4e',
        onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
  }

  @override
  Widget build(BuildContext context) {
    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();

    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: initialize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return NaverMap(
                options: const NaverMapViewOptions(
                  indoorEnable: false, // 실내 맵 사용 가능 여부 설정
                  locationButtonEnable: false, // 위치 버튼 표시 여부 설정
                  consumeSymbolTapEvents: true, // 심볼 탭 이벤트 소비 여부 설정
                  initialCameraPosition: NCameraPosition(
                    target: NLatLng(37.5300090111487, 126.969510593878),
                    zoom: 14,
                  ),
                ),
                onMapReady: (controller) async {
                  // 지도 준비 완료 시 호출되는 콜백 함수
                  mapControllerCompleter
                      .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
                  log("onMapReady", name: "onMapReady");
                },
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
