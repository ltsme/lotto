import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:provider/provider.dart';
import 'dart:math';

// Lotto 앱 메인 컬러
Color appMainColor = Colors.blue.shade300;

class LottoSignUpPageNick extends StatefulWidget {
  const LottoSignUpPageNick({super.key});

  @override
  State<LottoSignUpPageNick> createState() => _LottoSignUpPageNickState();
}

class _LottoSignUpPageNickState extends State<LottoSignUpPageNick> {
  TextEditingController nicknameController = TextEditingController();
  List nicknames = ['네잎 클로버, 행운, 럭키, 대박, 돼지 꿈 ,두근두근, 콩닥콩닥'];
  String nickname = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authservice, child) {
      User? user = authservice.currentUser();
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  // 공통 스타일
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 35),
                  children: [
                    TextSpan(
                      text: "L",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 35,
                      ),
                    ),
                    TextSpan(
                      text: "o",
                      style: TextStyle(
                        color: appMainColor,
                      ),
                    ),
                    TextSpan(
                      text: "tt",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const TextSpan(
                      text: "o",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    const TextSpan(
                      text: " ",
                      style: TextStyle(fontSize: 5),
                    ),
                    TextSpan(
                      text: "6",
                      style:
                          TextStyle(color: Colors.blue.shade700, fontSize: 19),
                    ),
                    const TextSpan(
                      text: "/",
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    TextSpan(
                      text: "45",
                      style:
                          TextStyle(color: Colors.blue.shade700, fontSize: 19),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 가운데 정렬 UI를을 위한 숨겨진 아이콘
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.abc, color: Colors.white),
            ),
          ],
          // title: Image.asset('assets/images/logo.png', height: 32),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 24, color: Colors.black),
                    children: [
                      TextSpan(
                          text: "닉네임",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "을 입력해 주세요!"),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "닉네임",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                TextField(
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  controller: nicknameController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Icon(Icons.abc),
                    border: InputBorder.none,
                    labelText: '닉네임',
                  ),
                ),
                const Text(
                  "닉네임은 5자 이하로 입력해 주세요.\n 닉네임을 입력하지 않을 경우 무작위 닉네임이 부여 됩니다🤣",
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nicknameController.text == null) {
                        nicknames.shuffle();
                        nickname = nicknames.first;
                        print("랜덤 Test : nickname = $nickname");
                      } else {
                        nickname = nicknameController.text;
                        print("입력한 Test nickname = $nickname");
                      }
                      // Firebase Store Nickname 등록과정
                      Navigator.pop(context);
                      signupDialog();
                    },
                    child: Text(
                      '회원 가입',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<bool> willPopScope() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: const Text("앱을 종료하시겠습니까?"),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  // true가 전달되어 앱이 종료 됨.
                  SystemNavigator.pop();
                },
                child: Text("예")),
            ElevatedButton(
                onPressed: () {
                  // false가 전달되어 앱이 종료 되지 않음
                  Navigator.pop(context, false);
                },
                child: Text("아니오")),
          ],
        );
      },
    );
  }

  void signupDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: const Text(
              "회원가입이 완료되었습니다!\n로그인 해 주세요",
            ),
            actions: [
              TextButton(
                child: const Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
