import 'package:flutter/material.dart';
import 'package:lotto/pages/getnumberpage.dart';
import 'package:lotto/pages/winningnumpage.dart';
import 'package:lotto/widgets/qrscanpage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Lotto 앱 메인 컬러
Color appMainColor = Colors.blue.shade400;

//포인트 색상
Color accentColor = const Color.fromARGB(255, 199, 176, 121);

String naverUrl =
    'https://m.search.naver.com/search.naver?sm=mtp_hty.top&where=m&query=%EB%84%A4%EC%9D%B4%EB%B2%84+%EC%9A%B4%EC%84%B8';
String lottoUrl = 'https://m.dhlottery.co.kr/gameResult.do?method=byWin';

class LottoFirstPage extends StatefulWidget {
  const LottoFirstPage({super.key});

  @override
  State<LottoFirstPage> createState() => _LottoFirstPageState();
}

class _LottoFirstPageState extends State<LottoFirstPage> {
  /// 배경 이미지 URL
  final String titleImg = "assets/images/lotto_title.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        // 우측 하단에 Deliverys 아이콘 띄우기 위해 Stack으로 구현
        children: [
          // Sliver 위젯들을 이용하기 위해 CustomScrollView를 사용한다.
          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
                pinned: true, // 스크롤 시 bottom 영역을 고정할 지
                snap: false, // 중간에 멈출 때 자동으로 AppBar를 펼쳐서 보여줄지
                floating: true, // AppBar를 화면에 띄울지, 아니면 컬럼처럼 최 상단에 놓을 지
                expandedHeight: 200,
                backgroundColor: Colors.red,

                // ---스크롤 시 사라질 영역, flexibleSpace
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Stack(
                    children: [
                      // 백 그라운드 이미지
                      Positioned.fill(
                        bottom: 40,
                        child: Image.asset(
                          titleImg,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 24,
                        right: 24,
                        top: 48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "로또 앱과 함께 \n1등까지! 🍀",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // ---스크롤 시 남아있는 영역, bottom
                // SliverAppBar의 bottom은 PrefereedSize 위젯으로 시작해야만 한다.
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(52), // 영역의 높이
                  child: Container(
                    height: 52,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "이번 추첨일 까지 / ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "D-day ?",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // CustomScrollView 안에서는 모든 첫 번째 위젯이 Sliver로 구현 되어야한다.
              // SliverToBoxAdapter는 Container와 같은 위젯으로 생각하자.
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QrScanPage(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.qr_code,
                                  size: 100,
                                ),
                              ),
                              SizedBox(width: 100),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WinningNumPage(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.check,
                                  size: 100,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 100),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => _launchURL(naverUrl),
                                icon: Icon(
                                  Icons.money,
                                  size: 100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: "주변 "),
                            TextSpan(
                              text: "로또 판매점",
                              style: TextStyle(color: Colors.green),
                            ),
                            TextSpan(text: "찾기"),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      child: Container(
                        width: 400,
                        height: 300,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Deliverys 위젯 추가 위해 Stack 위젯으로 감싼다.
          Positioned(
            bottom: 18,
            right: 24,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LottoGetNumberPage(),
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(64),
                ),
                child: Row(
                  children: [
                    Text(
                      "로또번호 뽑기",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(url) async {
    await canLaunchUrlString(url) // canLaunch 대신 canLaunchUrlString을 사용하자
        ? await launch(url)
        : throw 'Could not launch $url';
  }
}
