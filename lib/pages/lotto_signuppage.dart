import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto/pages/lotto_mainpage.dart';
import 'package:lotto/pages/lotto_signinpage.dart';
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
          body: WillPopScope(
            onWillPop: () => willPopScope(),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                      child: Image.asset(
                        'assets/images/icon.jpg',
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextField(
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        controller: emailController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.perm_identity),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: '아이디'),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextField(
                        obscureText: true,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        controller: passwordController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: '비밀번호'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // 로그인 버튼
                    Container(
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("로그인 성공")),
                                );

                                // 로그인 성공 시 HomePage로 이동하면서 uid를 보내줌
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
                        child: const Text(
                          '로그인',
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child:
                                Text('아이디 찾기', style: TextStyle(fontSize: 12))),
                        SizedBox(width: 4),
                        Text('|'),
                        SizedBox(width: 4),
                        TextButton(
                            onPressed: () {},
                            child: Text('비밀번호 찾기',
                                style: TextStyle(fontSize: 12))),
                        SizedBox(width: 4),
                        Text('|'),
                        SizedBox(width: 4),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LottoSignInPage(),
                              ),
                            );
                          },
                          child: Text('회원 가입', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey),
                          flex: 1,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          alignment: Alignment.center,
                          child: Expanded(
                            child: Text('이런 로그인도 가능해요!'),
                            flex: 2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/icon_lottery.png',
                          ),
                          iconSize: 50,
                        ),
                        const SizedBox(height: 12),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/icon_lottery.png',
                          ),
                          iconSize: 50,
                        ),
                      ],
                    )
                  ],
                ),
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
}
