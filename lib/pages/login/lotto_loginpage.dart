import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/lotto_mainpage.dart';
import 'package:lotto/pages/login/lotto_pwfindingpage.dart';
import 'package:lotto/pages/login/lotto_signuppage.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:lotto/widgets/dialog.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LottoLoginPage extends StatefulWidget {
  const LottoLoginPage({super.key});

  @override
  State<LottoLoginPage> createState() => _LottoLoginPageState();
}

class _LottoLoginPageState extends State<LottoLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthService>(builder: (context, authservice, child) {
        User? user = authservice.currentUser();

        return Scaffold(
          backgroundColor: Colors.white,
          body: WillPopScope(
            onWillPop: () => willPopScope(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 16),
                    child: SizedBox(
                      width: 300,
                      height: 120,
                      child: Image.asset(
                        'assets/images/icon.jpg',
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      controller: emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.perm_identity),
                          border: InputBorder.none,
                          focusColor: Colors.black,
                          focusedBorder: InputBorder.none,
                          hintText: '아이디'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      obscureText: true,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      controller: passwordController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.key),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: '비밀번호'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // 로그인 버튼
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        authservice.signIn(
                            email: emailController.text,
                            password: passwordController.text,
                            onSuccess: () {
                              FirebaseAuth.instance
                                  .authStateChanges()
                                  .listen((event) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("로그인 성공")),
                                );

                                // 로그인 성공 시 HomePage로 이동하면서 uid를 보내줌
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LottoMainPage()),
                                );
                              });
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error : $error")),
                              );
                            });
                      },
                      child: const Text(
                        '로그인',
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LottoSignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
                          '회원 가입',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('|'),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LottoPwFindingPage(),
                            ),
                          );
                        },
                        child: const Text(
                          '비밀번호 재 설정',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          '이런 로그인도 가능해요!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        flex: 1,
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            _googleAuthSignIn();

                            // FirebaseAuth.instance
                            //     .authStateChanges()
                            //     .listen((event) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(content: Text("로그인 성공")),
                            //   );

                            //   // 로그인 성공 시 HomePage로 이동하면서 uid를 보내줌
                            //   Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (_) =>
                            //           LottoMainPage(uid: event!.uid),
                            //     ),
                            //   );
                            //});
                          },
                          child: const Text(
                            'Google로 계속하기',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<bool> willPopScope() async {
    return await willPopDialogWidget(context);
  }

  void _googleAuthSignIn() async {
    try {
      //구글 Sign in 플로우 오픈
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //구글 인증 정보 읽어오기
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      //읽어온 인증정보로 파이어베이스 인증 로그인!
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("Logged with Google: ${userCredential.user}");

      FirebaseAuth.instance.authStateChanges().listen((event) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("로그인 성공")),
        );
      });

      _gotoPage();
    } catch (e) {
      print(e);
    }
    //파이어 베이스 Signin하고 결과(userCredential) 리턴햇!
    //return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _gotoPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LottoMainPage(),
      ),
    );
  }
}
