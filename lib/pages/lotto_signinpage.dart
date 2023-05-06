import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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

  final String eventImg = 'assets/images/advertise_image.png';

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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                  child: Image.asset(
                    'assets/images/icon.jpg',
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: '아이디'),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    obscureText: true,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: '비밀번호'),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    obscureText: true,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: '비밀번호 확인'),
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
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
                  child: Text('회원 가입', style: TextStyle(fontSize: 12)),
                ),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: passwordController,
                    maxLength:
                        10, // 최대 텍스트 필드 크기, 이것을 지정함으로써 counter가 자동 생성 (counterStyle:)
                    obscureText: true,
                    enabled: true,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                      ),
                      prefixIcon: Icon(Icons.perm_identity),
                      labelText: 'password',
                      helperText: '비밀번호는 10자 이상',
                      counterStyle: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onChanged: (text) {},
                    onSubmitted: (text) {
                      setState(() {
                        print(text);
                      });
                    },
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
