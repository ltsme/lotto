import 'package:flutter/material.dart';
import 'package:lotto/pages/getnumberpage.dart';
import 'package:lotto/pages/lotto_secondpage.dart';
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
  final String backImg = "assets/images/lotto_1.png";

  // 추천 번호
  final List<Map<String, String>> recommendMenu = const [
    {
      "imgUrl": "https://i.ibb.co/SwGPpzR/9200000003687-20211118142543832.jpg",
    },
    {
      "imgUrl": "https://i.ibb.co/JHVXZ72/9200000003690-20211118142702357.jpg",
    },
    {
      "imgUrl": "https://i.ibb.co/M91G17c/9200000003693-20211118142933650.jpg",
    },
    {
      "imgUrl": "https://i.ibb.co/jyZK4C9/9200000003696-20211118143125337.jpg",
    },
    {
      "imgUrl": "https://i.ibb.co/DKkV0rw/9200000003699-20211118143249044.jpg",
    },
  ];

  /// 크리스마스 이벤트 이미지 URL
  final String eventImg = 'assets/images/lotto_2.png';

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
                expandedHeight: 252,
                backgroundColor: Colors.white,

                // ---스크롤 시 사라질 영역, flexibleSpace
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Stack(
                    children: [
                      // 백 그라운드 이미지
                      Positioned.fill(
                        bottom: 50,
                        child: Image.asset(
                          backImg,
                          fit: BoxFit.fill,
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
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "이번 추첨일 까지 / ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
                        children: [
                          GestureDetector(
                            onTap: () => _launchURL(naverUrl),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "오늘의 운세",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          eventImg,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text("버튼 두개 들어갈 곳 (배민 느낌) \n QR 촬영, 번호 확인")),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 150, // height를 가져야 ListView를 Column에 넣을 수 있다.
                      child: Row(),
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
