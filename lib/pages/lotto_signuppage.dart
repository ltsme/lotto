import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/lotto_mainpage.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:provider/provider.dart';

class LottoSignUpPage extends StatefulWidget {
  const LottoSignUpPage({super.key});

  @override
  State<LottoSignUpPage> createState() => _LottoSignUpPageState();
}

class _LottoSignUpPageState extends State<LottoSignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthService>(builder: (context, authservice, child) {
        User? user = authservice.currentUser();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              '로그인',
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true, // 안드로이드에서 센터
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Image.network(
                      "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                      width: 81,
                    ),
                  ),
                  Center(
                    child: Text(
                      user == null ? "로그인해 주세요 🙂" : "${user.email}님, 안녕하세요😆",
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: '아이디'),
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(labelText: '비밀번호'),
                  ),
                  const SizedBox(height: 50),
                  // 로그인 버튼
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        authservice.signIn(
                            email: emailController.text,
                            password: passwordController.text,
                            onSuccess: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("로그인 성공")),
                              );
                              // 로그인 성공 시 HomePage로 이동
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LottoMainPage()),
                              );
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error : $error")),
                              );
                            });
                      },
                      child: const Text('로그인'),
                    ),
                  ),
                  // 회원가입 버튼
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        authservice.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          onSuccess: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("회원가입 성공")));
                          },
                          onError: (error) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(error)));
                          },
                        );
                      },
                      child: const Text('회원가입'),
                    ),
                  ),
                  // SizedBox(
                  //   width: 400,
                  //   child: TextField(
                  //     controller: passwordController,
                  //     maxLength:
                  //         10, // 최대 텍스트 필드 크기, 이것을 지정함으로써 counter가 자동 생성 (counterStyle:)
                  //     obscureText: true,
                  //     enabled: true,
                  //     keyboardType: TextInputType.phone,
                  //     decoration: const InputDecoration(
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: Colors.greenAccent,
                  //           width: 1.0,
                  //         ),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: Colors.red,
                  //           width: 1.0,
                  //         ),
                  //       ),
                  //       prefixIcon: Icon(Icons.perm_identity),
                  //       labelText: 'password',
                  //       helperText: '비밀번호는 10자 이상',
                  //       counterStyle: TextStyle(
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //     onChanged: (text) {},
                  //     onSubmitted: (text) {
                  //       setState(() {
                  //         print(text);
                  //       });
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
