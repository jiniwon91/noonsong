import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class population_complexity extends StatelessWidget {
  final String ppltnTime;
  const population_complexity({super.key, required this.ppltnTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 180,
          height: 100,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 180,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: const Color(0xB2FAFBFB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
              const Positioned(
                left: 10,
                top: 7,
                child: SizedBox(
                  width: 89,
                  height: 21.33,
                  child: Text(
                    '인구 분포',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 11,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 32.5,
                child: Container(
                  width: 40,
                  height: 40,
                  color: const Color(0xff00ba71),
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '여유',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 32.5,
                child: Container(
                  width: 40,
                  height: 40,
                  color: const Color(0xffFFAE00),
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '보통',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 90,
                top: 32.5,
                child: Container(
                  width: 40,
                  height: 40,
                  color: const Color(0xFFFF5E01),
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '약간\n붐빔',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 130,
                top: 32.5,
                child: Container(
                  width: 40,
                  height: 40,
                  color: const Color(0xffF43545),
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '붐빔',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 7,
                child: Text(
                  '$ppltnTime 기준',
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 10,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
