import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/login/lotto_loginpage.dart';
import 'package:lotto/widgets/dialog.dart';

class LottoOnboardingPage extends StatefulWidget {
  const LottoOnboardingPage({super.key});

  @override
  State<LottoOnboardingPage> createState() => _LottoOnboardingPageState();
}

class _LottoOnboardingPageState extends State<LottoOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => willPopScope(),
        child: IntroductionScreen(
          pages: [
            // onBoarding 페이지 1
            PageViewModel(
              title: "로또,",
              body: "어떻게 하고 계셨나요 ?",
              image: SizedBox(
                width: 250,
                height: 200,
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
            // onBoarding 페이지 2
            PageViewModel(
              title: "앱 하나로",
              body: "즐기는 1주의 두근거림",
              image: SizedBox(
                width: 250,
                height: 200,
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
            // onBoarding 페이지 3
            PageViewModel(
              title: "꿈은 이루어 진다 ⭐️",
              body: "LottoMaker가 함께 합니다.",
              image: SizedBox(
                width: 250,
                height: 200,
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
          done: const Text(
            "시작하기",
            style: TextStyle(
              color: Colors.green,
              fontSize: 18,
            ),
          ),
          onDone: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LottoLoginPage()),
            );
          },
          next: const Icon(Icons.arrow_forward, color: Colors.black, size: 24),
          back: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
          showBackButton: true,
          showDoneButton: true,
          showNextButton: true,
          dotsDecorator: const DotsDecorator(activeColor: Colors.black),
        ),
      ),
    );
  }

  Future<bool> willPopScope() async {
    return await WillPopDialogWidget(context);
  }
}
