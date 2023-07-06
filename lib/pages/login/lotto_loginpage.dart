import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto/pages/lotto_mainpage.dart';
import 'package:lotto/pages/login/lotto_pwfindingpage.dart';
import 'package:lotto/pages/login/lotto_signuppage.dart';
import 'package:lotto/widgets/auth_service.dart';
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
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 16),
                    child: Image.asset(
                      'assets/images/icon.jpg',
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      controller: emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.perm_identity),
                          border: InputBorder.none,
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
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      controller: passwordController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.key),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: '비밀번호'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 로그인 버튼
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
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
                                  SnackBar(content: Text("로그인 성공")),
                                );

                                // 로그인 성공 시 HomePage로 이동하면서 uid를 보내줌
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          LottoMainPage(uid: event!.uid)),
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
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LottoPwFindingPage(),
                              ),
                            );
                          },
                          child: Text('비밀번호 재 설정',
                              style: TextStyle(fontSize: 12))),
                      SizedBox(width: 4),
                      Text('|'),
                      SizedBox(width: 4),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LottoSignUpPage(),
                            ),
                          );
                        },
                        child: Text('회원 가입', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                        flex: 1,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        alignment: Alignment.center,
                        child: const Expanded(
                          child: Text('이런 로그인도 가능해요!'),
                          flex: 2,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                        flex: 1,
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
                            shape: StadiumBorder(),
                          ),
                          onPressed: () {
                            //googleAuthSignIn();

                            googleAuthSignIn();

                            FirebaseAuth.instance
                                .authStateChanges()
                                .listen((event) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("로그인 성공")),
                              );

                              // 로그인 성공 시 HomePage로 이동하면서 uid를 보내줌
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        LottoMainPage(uid: event!.uid)),
                              );
                            });
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

  Future<UserCredential> googleAuthSignIn() async {
    //구글 Sign in 플로우 오픈
    final GoogleSignInAccount? googleUser = await GoogleSignIn()?.signIn();

    //구글 인증 정보 읽어오기
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    //읽어온 인증정보로 파이어베이스 인증 로그인!
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    //파이어 베이스 Signin하고 결과(userCredential) 리턴햇!
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
