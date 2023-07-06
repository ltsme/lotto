import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:provider/provider.dart';

import 'lotto_signuppage_nick.dart';

// Lotto 앱 메인 컬러
Color appMainColor = Colors.blue.shade300;

class LottoSignUpPage extends StatefulWidget {
  const LottoSignUpPage({super.key});

  @override
  State<LottoSignUpPage> createState() => _LottoSignUpPageState();
}

class _LottoSignUpPageState extends State<LottoSignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();

  String idCheckMessage = '사용 가능한 아이디입니다.';
  bool idChk = true;

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
                          text: "아이디와 비밀번호",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "만으로"),
                      TextSpan(text: "\n우린 "),
                      TextSpan(
                          text: "친구",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "가 될 수 있어요!"),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: "이메일"),
                      TextSpan(text: "*", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  controller: emailController,
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
                    prefixIcon: Icon(Icons.perm_identity),
                    border: InputBorder.none,
                    labelText: '아이디',
                  ),
                ),
                const SizedBox(height: 24),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: "비밀번호"),
                      TextSpan(text: "*", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  obscureText: true,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  controller: passwordController,
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
                      prefixIcon: Icon(Icons.key),
                      border: InputBorder.none,
                      labelText: '비밀번호'),
                ),
                const SizedBox(height: 8),
                Text(
                  '비밀번호는 문자와 숫자를 포함해 6~16자로 입력해주세요.',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 18),
                TextField(
                  obscureText: true,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  controller: passwordCheckController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Icon(Icons.key),
                    hintText: '비밀번호 확인',
                    labelText: '비밀번호 확인',
                  ),
                  onChanged: (text) {},
                  onSubmitted: (text) {
                    setState(() {
                      print(text);
                    });
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      authservice.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        passwordcheck: passwordCheckController.text,
                        onSuccess: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LottoSignUpPageNick(),
                              ));
                        },
                        onError: (error) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(error)));
                        },
                      );
                    },
                    child: Text(
                      '다음',
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
}
