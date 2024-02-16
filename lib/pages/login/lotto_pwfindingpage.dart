import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/login/lotto_signuppage.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:provider/provider.dart';

class LottoPwFindingPage extends StatefulWidget {
  const LottoPwFindingPage({super.key});

  @override
  State<LottoPwFindingPage> createState() => _LottoPwFindingPageState();
}

class _LottoPwFindingPageState extends State<LottoPwFindingPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController dialogController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authservice, child) {
      User? user = authservice.currentUser();

      return Scaffold(
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
                const Text(
                  '비밀번호 재 설정',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: "이메일"),
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
                    labelText: '이메일',
                  ),
                ),
                TextField(
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.amber),
                  controller: dialogController,
                  enabled: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isEmpty) {
                        setState(() {
                          dialogController.text = '이메일을 입력해 주세요';
                        });
                      } else {
                        await FirebaseAuth.instance.setLanguageCode("kr");
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text);
                        pwDialog();
                      }
                    },
                    child: const Text(
                      '찾기',
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

  void pwDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: const Text(
              "비밀번호 재 설정 이메일이\n전송되었습니다! 😜",
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                child: const Text("확인"),
                onPressed: () {
                  emailController.text = '';
                  dialogController.text = '';
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
