import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/lotto_mainpage.dart';
import 'package:lotto/pages/lotto_signuppage.dart';

class LottoOnboardingPage extends StatelessWidget {
  const LottoOnboardingPage({super.key});

  // 이벤트 이미지 URL
  final String eventImg = 'assets/images/advertise_image.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
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
                fontSize: 20,
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
                fontSize: 20,
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
            footer: Container(
              padding: const EdgeInsets.symmetric(vertical: 50),
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LottoSignUpPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: const StadiumBorder(),
                ),
                child: const Text("로그인"),
              ),
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
                fontSize: 20,
              ),
            ),
          ),
        ],
        showDoneButton: false,
        showNextButton: false,
        dotsDecorator: const DotsDecorator(activeColor: Colors.black),
      ),
    );
  }
}
