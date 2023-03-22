import 'package:lotto/pages/lotto_mainpage.dart';
import 'package:lotto/pages/lotto_onboardingpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // SharedPreferences에서 온보딩 여부 확인,
    bool isOnboarded = preferences.getBool("isOnboarded") ?? false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.getTextTheme('Jua')),
      // 삼항 연산자를 이용하여, bool 값에 따라 호출을 다르게 한다.
      home: isOnboarded ? const LottoMainPage() : const LottoOnboardingPage(),

      // Shared_preference에 isOnboarde에 해당하는 bool값 지정
      // preferences.setBool("isOnboarded", true);
    );
  }
}
