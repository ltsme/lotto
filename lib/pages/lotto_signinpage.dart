import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:provider/provider.dart';

class LottoSignInPage extends StatefulWidget {
  const LottoSignInPage({super.key});

  @override
  State<LottoSignInPage> createState() => _LottoSignInPageState();
}

class _LottoSignInPageState extends State<LottoSignInPage> {
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
        appBar: AppBar(
          title: const Text(
            '회원가입',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true, // 안드로이드에서 센터
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
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
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: "아이디"),
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
                      suffixText: '중복체크'),
                ),
                const SizedBox(height: 24),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        fontSize: 14,
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
                const Text(
                  '비밀번호는 영문 대소문자, 숫자를 혼합하여 8~16자로 입력해주세요.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
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
                const Text(
                  "닉네임",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
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
                      prefixIcon: Icon(Icons.abc),
                      border: InputBorder.none,
                      labelText: '닉네임',
                      suffixText: '중복체크'),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      authservice.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        onSuccess: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("회원가입 성공")));
                        },
                        onError: (error) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(error)));
                        },
                      );
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
}
