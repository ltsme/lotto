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

  @override
  Widget build(BuildContext context) {
    // 로그인 여부 체크 후, OnboardingPage또는 LottoMainpage를 띄운다.
    User? user = context.read<AuthService>().currentUser();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.getTextTheme('Jua')),
      home: user == null ? const LottoOnboardingPage() : const LottoMainPage(),
    );
  }
}
