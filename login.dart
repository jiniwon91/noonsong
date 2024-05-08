import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'register.dart';

class LoginEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFF7F8FA)),
          child: Stack(
            children: [
              Positioned(
                left: 59,
                top: 536.19,
                child: SizedBox(
                  width: 241.73,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '첫 사용이신가요?',
                          style: TextStyle(
                            color: Color(0xFFACADB9),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.16,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Color(0xFFACADB9),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: -0.16,
                          ),
                        ),
                        TextSpan(
                          text: '회원가입',
                          recognizer: new TapGestureRecognizer()..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(body: ListView(children: [ RegisterEmpty()]))));
                          },
                          style: TextStyle(
                            color: Color(0xFF323142),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.32,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 221,
                child: Container(
                  width: 310,
                  height: 303.52,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 238,
                        child: Container(
                          width: 310,
                          height: 65.52,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 310,
                                  height: 65.52,
                                  /*decoration: ShapeDecoration(
                                    color: Color(0xFF141718),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),*/
                                  child: Container(
                                    width: 62,
                                    child: ElevatedButton(
                                    //style: ButtonStyle(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF141718),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14))),
                                      onPressed:(){
                                      
                                      },
                                      child: Text(
                                        '확인',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFF3F5F6),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                          letterSpacing: -0.32,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 153.24,
                        child: Container(
                          width: 310,
                          height: 65.52,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,//56,
                                top: 0,//23.81,
                                child:SizedBox(
                                  width: 310,
                                  height: 65.52,
                                  child: TextFormField(
                                    obscureText: true,
                                    style:TextStyle(                                      
                                      color: Color(0xFF141718),
                                      fontSize: 14,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                      letterSpacing: -0.28,
                                    ),
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.visibility_off),
                                      prefixIcon: Icon(Icons.lock),
                                      filled: true,
		                                  fillColor: Colors.white,
                                      hintText: 'Password',
                                      hintStyle:TextStyle(
                                        color: Color(0xFFC2C3CB),
                                        fontSize: 14,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 6,
                                        letterSpacing: -0.28,                                      
                                      ),                                      
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2, color: Colors.white),
                                        borderRadius: BorderRadius.circular(12.84),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2, color: Color(0xFF141718)),
                                        borderRadius: BorderRadius.circular(12.84),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 68.19,
                        child: Container(
                          width: 310,
                          height: 65.52,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,//56,
                                top: 0,//23.81,
                                child:SizedBox(
                                  width: 310,
                                  height: 65.52,
                                  child: TextFormField(
                                    style:TextStyle(
                                      color: Color(0xFF141718),
                                      fontSize: 14,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                      letterSpacing: -0.28,
                                    ),
                                    decoration: InputDecoration(                                      
                                      prefixIcon: Icon(Icons.person),
                                      filled: true,
		                                  fillColor: Colors.white,
                                      hintText: 'e-mail',
                                      hintStyle:TextStyle(
                                        color: Color(0xFFC2C3CB),
                                        fontSize: 14,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 6,
                                        letterSpacing: -0.28,                                      
                                      ),                                      
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2, color: Colors.white),
                                        borderRadius: BorderRadius.circular(12.84),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2, color: Color(0xFF141718)),
                                        borderRadius: BorderRadius.circular(12.84),
                                      )
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20.65,
                                top: 22.81,
                                child: Container(
                                  width: 16.41,
                                  height: 19.19,
                                  child: Stack(children: [
                                  
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: SizedBox(
                          width: 270.63,
                          child: Text(
                            '로그인',
                            style: TextStyle(
                              color: Color(0xFF323142),
                              fontSize: 38,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 0.03,
                              letterSpacing: -0.76,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /*Positioned(
                left: 0,
                top: 758,
                child: Container(
                  width: 360,
                  height: 42,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 273,
                        top: 29,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3FFFFFFF),
                                blurRadius: 0.30,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 15,
                                child: Container(width: 15, height: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 72,
                        top: 29,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3FFFFFFF),
                                blurRadius: 0.30,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 15,
                                child: Container(width: 15, height: 15),
                              ),
                              Positioned(
                                left: 12,
                                top: 1,
                                child: Container(
                                  width: 2,
                                  height: 13,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF717171),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.10),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 7,
                                top: 1,
                                child: Container(
                                  width: 2,
                                  height: 13,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF717171),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.10),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 2,
                                top: 1,
                                child: Container(
                                  width: 2,
                                  height: 13,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF717171),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 173,
                        top: 14,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3FFFFFFF),
                                blurRadius: 0.30,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(width: 15, height: 15),
                              ),
                              Positioned(
                                left: 1,
                                top: 14,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1.88, color: Color(0xFF717171)),
                                      borderRadius: BorderRadius.circular(4.95),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
              /*Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 360,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 128,
                        height: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '9:30',
                              style: TextStyle(
                                color: Color(0xFF191C1B),
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                                letterSpacing: 0.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Stack(children: [
                                    
                                    ]),
                                  ),
                                  Container(
                                    width: 16,
                                    height: 16,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Stack(children: [
                                    
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 16,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Stack(children: [
                                    
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ],
    );
  }
}