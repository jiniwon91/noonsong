import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class RegisterEmpty extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();
  TextEditingController passwdck = TextEditingController();
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
                top: 595.19,
                child: SizedBox(
                  width: 241.73,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '이미 계정이 있으신가요?',
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
                          text: '로그인',
                          recognizer: new TapGestureRecognizer()..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(body: ListView(children: [ LoginEmpty()]))));//LoginEmpty()));
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
                top: 195,
                child: Container(
                  width: 310,
                  height: 388.52,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 323,
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
                                  child: Container(
                                    width: 62,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF141718),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14))),
                                      onPressed:(){
                                        checkPossiblePasswordText(passwd.text);
                                      // 이메일이 입력되었는지 확인(이메일 형태가 맞는지)

                                      // 비밀번호가 입력되었는지 확인(유효성 검사)
                                      // 비밀번호 체크 입력되었는지 확인(비밀번호와 같은지)
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
                                  child: TextFormField(
                                    controller: passwdck,
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
                                      hintText: 'Password Check',
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
                              Positioned(
                                left: 277.33,
                                top: 20.75,
                                child: Container(
                                  width: 16.67,
                                  height: 18.50,
                                  child: Stack(children: [
                                  
                                  ]),
                                ),
                              ),
                              Positioned(
                                left: 20.65,
                                top: 20.89,
                                child: Container(
                                  width: 15.48,
                                  height: 19.27,
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
                        top: 153,
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
                                  child : TextFormField(
                                    controller: passwd,
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
                              Positioned(
                                left: 277.33,
                                top: 22.75,
                                child: Container(
                                  width: 16.67,
                                  height: 18.50,
                                  child: Stack(children: [
                                  
                                  ]),
                                ),
                              ),
                              Positioned(
                                left: 20.65,
                                top: 22.89,
                                child: Container(
                                  width: 15.48,
                                  height: 19.27,
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
                        top: 68.19,
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
                                  child: TextFormField(
                                    controller: email,
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
                            '회원가입',
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
            ],
          ),
        ),
      ],
    );
  }
}

class CorrectWordParameter {
  bool is8Characters;
  bool is1Symbol;
  bool is1Letter;
  bool is1Number;
  CorrectWordParameter({this.is8Characters = false, this.is1Symbol = false, this.is1Letter = false, this.is1Number = false});
  bool get isCorrectWord => (is8Characters && is1Symbol && is1Letter && is1Number);
}

CorrectWordParameter checkPossiblePasswordText(String value) {     
  var correctWordParameter = CorrectWordParameter();
  final  validNumbers = RegExp(r'(\d+)');
  final  validAlphabet = RegExp(r'[a-zA-Z]');
  final  validSpecial = RegExp(r'^[a-zA-Z0-9 ]+$');  

  //문자가 비었는지 확인
  if(value.isEmpty) {   
      // 문자가 비었다면 모드 false로 리턴
      return CorrectWordParameter();
  }

  //8자 이상인지 확인
  if(value.length >= 8) { 
    correctWordParameter.is8Characters = true;
  }
  else {
    correctWordParameter.is8Characters = false;
  }

  //특수기호가 있는지 확인
  if(!validSpecial.hasMatch(value)) {
    correctWordParameter.is1Symbol = true;
  }
  else {
    correctWordParameter.is1Symbol = false;      
  }

  //문자가 있는지 확인
  if(!validAlphabet.hasMatch(value)) {
    correctWordParameter.is1Letter = false;
  }
  else {
    correctWordParameter.is1Letter = true;      
  }
  
  //숫자가 있는지 확인        
  if(validNumbers.hasMatch(value)) {
    correctWordParameter.is1Number = true;
  }
  else {
    correctWordParameter.is1Number = false;
  }
  return correctWordParameter;
}

/////////// 테스트 코드 ///////////////////////
void main(List<String> arguments) async {
  var text = 'abcd@122';
  var correct = checkPossiblePasswordText(text);  
  print('input text: $text');
  print('is correct word  : ${correct.isCorrectWord }');
  print('more than 8 vharacters : ${correct.is8Characters}');
  print('speicail vharacters : ${correct.is1Symbol}');
  print('letter : ${correct.is1Letter}');
  print('number : ${correct.is1Number}');
}