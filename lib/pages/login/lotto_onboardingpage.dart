import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/login/lotto_loginpage.dart';

class LottoOnboardingPage extends StatefulWidget {
  const LottoOnboardingPage({super.key});

  @override
  State<LottoOnboardingPage> createState() => _LottoOnboardingPageState();
}

class _LottoOnboardingPageState extends State<LottoOnboardingPage> {
  // 이벤트 이미지 URL
  final String eventImg = 'assets/images/advertise_image.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => willPopScope(),
        child: IntroductionScreen(
          pages: [
            // 페이지1
            PageViewModel(
              title: "로또,",
              body: "어떻게 하고 계셨나요 ?",
              image: Padding(
                padding: const EdgeInsets.all(32),
                child: Image.asset('assets/images/icon.jpg'),
              ),
              decoration: const PageDecoration(
                boxDecoration: BoxDecoration(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.green,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                bodyTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
            // 페이지2
            PageViewModel(
              title: "앱 하나로",
              body: "편리하게 즐기는 1주의 두근거림",
              image: Padding(
                padding: const EdgeInsets.all(32),
                child: Image.asset('assets/images/icon.jpg'),
              ),
              decoration: const PageDecoration(
                boxDecoration: BoxDecoration(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.green,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                bodyTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
            // 페이지3
            PageViewModel(
              title: "꿈은 이루어 진다 ⭐️",
              body: " 그 옆에 LottoMaker가 함께 합니다.",
              image: Padding(
                padding: const EdgeInsets.all(32),
                child: Image.asset('assets/images/icon.jpg'),
              ),
              decoration: const PageDecoration(
                boxDecoration: BoxDecoration(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.green,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                bodyTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
          ],
          done: const Text("시작하기"),
          onDone: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LottoLoginPage()),
            );
          },
          next: const Icon(Icons.arrow_forward),
          back: const Icon(Icons.arrow_back),
          showBackButton: true,
          showDoneButton: true,
          showNextButton: true,
          dotsDecorator: const DotsDecorator(activeColor: Colors.black),
        ),
      ),
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
