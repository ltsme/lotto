import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lotto/pages/lotto_mainpage.dart';
import 'package:lotto/pages/login/lotto_onboardingpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:lotto/widgets/lotto_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main() 함수에서 async를 쓰려면 필요
  await Firebase.initializeApp(); // firebase 앱 시작

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => LottoService()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 이 위젯은 애플리케이션의 루트에 해당합니다.
  @override
  Widget build(BuildContext context) {
    // 로그인 여부 체크 후, OnboardingPage또는 LottoMainpage를 띄운다.
    User? user = context.read<AuthService>().currentUser();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 애플리케이션의 테마를 설정합니다.
      theme: ThemeData(textTheme: GoogleFonts.getTextTheme('Jua')),
      home: user == null
          ? const LottoOnboardingPage()
          : LottoMainPage(
              uid: user.uid,
            ),
    );
  }
}
