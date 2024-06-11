import 'package:flutter/material.dart';
import 'package:nunsong/widgets/home_button.dart';
import 'package:nunsong/screens/map_YongSan.dart';
import 'package:nunsong/screens/map_Itaewon.dart';
import 'package:nunsong/screens/map_Haebangchon.dart';
import 'package:nunsong/screens/map_HangangPark.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: 135,
                    height: 145,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://nunsong.s3.ap-northeast-2.amazonaws.com/frontend/character/nunsong.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      '눈송밀집분포도',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        fontSize: 35,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.70,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 350,
                    child: Text(
                      '열심히 공부한 당신, 떠나라!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w300,
                        height: 0.09,
                        letterSpacing: -0.32,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Flexible(
            flex: 1,
            child: Column(
              children: [
                homeButton(
                  location: '용산역 · 용리단길 · 삼각지역',
                  destination: Map_YongSan(),
                ),
                SizedBox(
                  height: 30,
                ),
                homeButton(
                  location: '이태원역',
                  destination: Map_Itaewon(),
                ),
                SizedBox(
                  height: 30,
                ),
                homeButton(
                  location: '해방촌 · 경리단길',
                  destination: Map_Haebangchon(),
                ),
                SizedBox(
                  height: 30,
                ),
                homeButton(
                  location: '이촌한강공원 · 노들섬',
                  destination: Map_HangangPark(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
