import 'package:flutter/material.dart';
import 'pages/lotto_firstpage.dart';
import 'pages/lotto_thirdpage.dart';
import 'pages/lotto_secondpage.dart';
import 'main.dart';

class LottoHomePage extends StatefulWidget {
  const LottoHomePage({Key? key}) : super(key: key);

  @override
  State<LottoHomePage> createState() => _LottoHomePage();
}

class _LottoHomePage extends State<LottoHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
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
                  TextSpan(
                    text: " ",
                    style: TextStyle(fontSize: 5),
                  ),
                  TextSpan(
                    text: "6",
                    style: TextStyle(color: Colors.blue.shade700, fontSize: 19),
                  ),
                  const TextSpan(
                    text: "/",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                  TextSpan(
                    text: "45",
                    style: TextStyle(color: Colors.blue.shade700, fontSize: 19),
                  ),
                ],
              ),
            ),
          ],
        ),
        // title: Image.asset('assets/images/logo.png', height: 32),
        actions: [
          IconButton(
            onPressed: () {
              preferences.clear(); // 테스트 용
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          LottoFirstPage(),
          LottoSecondPage(),
          LottoThirdPage(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          // bottomNavigationBar 클릭 시, 페이지 이동
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: appMainColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
        backgroundColor: Colors.white.withOpacity(0.7),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈페이지"),
          BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list_outlined), label: "뽑기 내역"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "마이 로또"),
        ],
      ),

      // AppBar 왼쪽에 아이콘을 누를 때 왼쪽에서 오른쪽으로 나오는 위젯
      drawer: Drawer(
        child: Column(
          children: [
            // Drawer 윗 부분
            DrawerHeader(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: SizedBox(
                width: double.infinity, // 가득 채우기
                child: Column(
                  children: [
                    /// 동그란 배경
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                        /// 이미지
                        child: Image.network(
                          "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                          width: 62,
                        ),
                      ),
                    ),

                    /// 닉네임 상단 여백
                    SizedBox(height: 16),

                    /// 닉네임
                    Text(
                      "닉네임",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// 이메일
                    Text(
                      "hello@world.com",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 이벤트 배너, 특정 비율로 위젯을 보여주기
            AspectRatio(
              aspectRatio: 12 / 4, // 가로 : 세로 = 12 : 4
              //스크롤을 하는데, 특정 항목이 스냅이 걸리도록 만들고 싶은 경우 PageView를 사용해요.
              child: PageView(
                children: [
                  Image.network(
                    "https://i.ibb.co/Q97cmkg/sale-event-banner1.jpg",
                  ),
                  Image.network(
                    "https://i.ibb.co/GV78j68/sale-event-banner2.jpg",
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  /// 구매 내역
                  ListTile(
                    title: const Text(
                      '내 구매 내역',
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                    onTap: () {
                      // 클릭시 drawer 닫기
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
