import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/lotto_mainpage_home.dart';
import 'package:lotto/pages/lotto_signinpage.dart';

class LottoOnboardingPage extends StatelessWidget {
  const LottoOnboardingPage({super.key});

  /// 크리스마스 이벤트 이미지 URL
  final String eventImg = 'assets/images/advertise_image.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          // 페이지1
          PageViewModel(
            title: "로또,",
            body: "어떻게 하고 계시나요?",
            footer: Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("로그인"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: StadiumBorder(),
                ),
              ),
            ),
            image: Padding(
              padding: const EdgeInsets.all(50),
              child: Image.asset('assets/images/icon.jpg'),
            ),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.green,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          // 페이지2
          PageViewModel(
            title: "앱 하나로",
            body: "편리하게 즐기는 1주의 두근거림",
            image: Padding(
              padding: EdgeInsets.all(32),
            ),
            footer: Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("로그인"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: StadiumBorder(),
                ),
              ),
            ),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.green,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          // 페이지3
          PageViewModel(
            title: "꿈은 이루어 진다 ⭐️",
            body: " 그 옆에 LottoMaker가 함께 합니다.",
            image: Padding(
              padding: EdgeInsets.all(32),
            ),
            footer: Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("로그인"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: StadiumBorder(),
                ),
              ),
            ),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.green,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          PageViewModel(
            title: "",
            body: "",
            image: Padding(
              padding: EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  eventImg,
                ),
              ),
            ),
            footer: Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LottoMainPageHome(),
                    ),
                  );
                },
                child: const Text("임시 로그인"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: StadiumBorder(),
                ),
              ),
            ),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.green,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
        showDoneButton: false,
        showNextButton: false,
        dotsDecorator: DotsDecorator(activeColor: Colors.black),
        onDone: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LottoSignInPage()),
          );
        },
      ),
    );
  }
}
