import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto/pages/login/lotto_loginpage.dart';
import 'package:lotto/widgets/appbar.dart';
import 'package:lotto/widgets/dialog.dart';
import 'package:provider/provider.dart';
import '../widgets/auth_service.dart';
import 'lotto_mainpage_home.dart';
import 'lotto_mainpage_mypage.dart';
import 'lotto_mainpage_lottolist.dart';

class LottoMainPage extends StatefulWidget {
  String uid = '';
  LottoMainPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<LottoMainPage> createState() => _LottoMainPage();
}

class _LottoMainPage extends State<LottoMainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context),
      body: WillPopScope(
        onWillPop: () => willPopScope(),
        child: IndexedStack(
          index: currentIndex,
          children: [
            LottoMainPageHome(),
            LottoMainPageLottolist(),
            LottoMainPageMyPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          // bottomNavigationBar 클릭 시, 페이지 이동
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈페이지"),
          BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list_outlined), label: "뽑기 내역"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "마이 로또"),
        ],
      ),
    );
  }

  // 뒤로가기 버튼 이벤트
  Future<bool> willPopScope() async {
    return await WillPopDialogWidget(context);
  }
}
