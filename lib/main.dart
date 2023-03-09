import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lotto_main.dart';

late SharedPreferences preferences;

void main() async {
  // main() 함수에서 async를 쓰려면 필요
  WidgetsFlutterBinding.ensureInitialized();

  // Shared_preferences 인스턴스 생성
  preferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SharedPreferences에서 온보딩 여부 조회, 값이 없는 경우 false 할당
    bool isOnboarded = preferences.getBool("isOnboarded") ?? false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.getTextTheme('Jua')),
      // 삼항 연산자를 이용하여, bool 값에 따라 호출을 다르게 한다.
      home: isOnboarded ? const LottoHomePage() : const OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          // 페이지1
          PageViewModel(
            title: "빠른 개발",
            body: "Flutter의 hot reload는 쉽고 UI 빌드를 도와줍니다",
            image: Padding(
              padding: EdgeInsets.all(32),
              child: Image.network(
                  "https://user-images.githubusercontent.com/26322627/143761841-ba5c8fa6-af01-4740-81b8-b8ff23d40253.png"),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.blueAccent,
                fontSize: 24,
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
            title: "표현력 있고 유연한 UI",
            body: "Flutter에 내장된 아름다운 위젯들로 사용자를 기쁘게 하세요",
            image: Padding(
              padding: EdgeInsets.all(32),
              child: Image.network(
                  "https://user-images.githubusercontent.com/26322627/143762620-8cc627ce-62b5-426b-bc81-a8f578e8549c.png"),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.blueAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
        next: Text(
          "Next",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        done: Text(
          "Done",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onDone: () {
          // Shared_preference에 isOnboarde에 해당하는 bool값 지정
          preferences.setBool("isOnboarded", true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LottoHomePage()),
          );
        },
      ),
    );
  }
}
