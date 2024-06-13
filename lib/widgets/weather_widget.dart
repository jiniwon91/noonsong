import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  final double TEMP;
  final String SKY_STTS;

  const WeatherWidget({
    super.key,
    required this.TEMP,
    required this.SKY_STTS,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isDaytime = now.hour >= 5 && now.hour < 19;

    String getImageUrl() {
      switch (SKY_STTS) {
        case '맑음':
          return isDaytime
              ? 'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/weather/sunny_day.png'
              : 'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/weather/sunny_night.png';
        case '구름조금':
          return isDaytime
              ? 'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/weather/cloudness_less_day.png'
              : 'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/weather/cloudness_less_night.png';
        case '구름많음':
          return isDaytime
              ? 'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/weather/cloudness_more_day.png'
              : 'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/weather/cloudness_more_night.png';
        case '흐림':
          return 'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/weather/cloudy.png';
        case '눈':
          return 'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/weather/snowy.png';
        case '비':
          return 'https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/weather/rainy.png';
        default:
          return '';
      }
    }

    return Column(
      children: [
        SizedBox(
          width: 90,
          height: 120,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 90,
                  height: 120,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAFBFB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x19191C32),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      getImageUrl(),
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${TEMP.toStringAsFixed(1)}ºC',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
