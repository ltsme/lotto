import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:lotto/widgets/dialog.dart';
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 72),
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
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
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
    return await WillPopDialogWidget(context);
  }
}
