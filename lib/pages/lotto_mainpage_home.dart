import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto/pages/lotto_getnumberpage.dart';
import 'package:lotto/widgets/lotto_ball.dart';
import 'package:lotto/widgets/qrscan.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

// Lotto 앱 메인 컬러
Color appMainColor = Colors.blue.shade400;

//포인트 색상
Color accentColor = const Color.fromARGB(255, 199, 176, 121);

String naverUrl =
    'https://m.search.naver.com/search.naver?sm=mtp_hty.top&where=m&query=%EB%84%A4%EC%9D%B4%EB%B2%84+%EC%9A%B4%EC%84%B8';

int lottoRoundNum = 1059; // 임시로 상수 사용, 이후 업데이트 예정

class LottoMainPageHome extends StatefulWidget {
  const LottoMainPageHome({super.key});

  @override
  State<LottoMainPageHome> createState() => _LottoMainPageHome();
}

class _LottoMainPageHome extends State<LottoMainPageHome> {
  // Lotto API 데이터
  var lottoData;
  final textController = TextEditingController(text: '$lottoRoundNum');
  final dialogController = TextEditingController(text: '');

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
                          children: const [
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
                        children: const [
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 기능 1. QR스캔하기
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QrScan(),
                                    ),
                                  );
                                },
                                icon: Image.asset(
                                  'assets/images/icon_qr.png',
                                ),
                                iconSize: 100,
                                tooltip: 'QR스캔하기',
                              ),
                              const Text('QR스캔하기')
                            ],
                          ),
                          const SizedBox(width: 15),
                          // 기능 2. 로또 회차 당첨번호 확인
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _winningNumDialog();
                                },
                                icon: Image.asset(
                                    'assets/images/icon_lottery.png'),
                                iconSize: 100,
                                tooltip: '당첨번호 확인',
                              ),
                              const Text('당첨번호 확인')
                            ],
                          ),
                          const SizedBox(width: 15),
                          // 기능 3. 오늘의 운세 (네이버)
                          Column(
                            children: [
                              IconButton(
                                onPressed: () => _launchURL(naverUrl),
                                icon: Image.asset(
                                    'assets/images/icon_clover.png'),
                                iconSize: 100,
                                tooltip: '오늘의 운세',
                              ),
                              const Text('오늘의 운세')
                            ],
                          ),
                        ],
                      ),
                    ),
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
                              text: "로또 판매점 ",
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
          // 기능 4. 로또 번호 생성하기
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
                  children: const [
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

  // 당첨 회차 입력하는 대화 상자 메소드
  void _winningNumDialog() {
    String dialogTxt = '';
    showDialog(
      context: context,
      barrierDismissible: true, //  빈 곳을 눌렀을 때, 창이 닫히는 지
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Column(
            children: [
              const Text(
                '회차를 입력해 주세요! ',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                "(이번 회차는 $lottoRoundNum회 입니다.)",
                style: const TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Colors.grey,
                    fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Column(
            // alertDialog에 Column 넣을 경우 사이즈 고정
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 20,
                    child: TextField(
                      controller: textController,
                      maxLength: 4,
                      enabled: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: '',
                      ),
                    ),
                  ),
                  const Text(" 회"),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.amber),
                controller: dialogController,
                enabled: false,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("취소"),
              onPressed: () {
                Navigator.pop(context);
                textController.text = '';
                dialogController.text = '';
              },
            ),
            TextButton(
              child: const Text("확인"),
              onPressed: () {
                if (textController.text.isEmpty) {
                  setState(() {
                    dialogController.text = '숫자를 입력해 주세요!';
                  });
                } else {
                  textController.text = '';
                  dialogController.text = '';
                  Navigator.pop(context);
                  _showWinningNum(int.parse(textController.text));
                }
              },
            ),
          ],
        );
      },
    );
  }

  // 당첨 회차 보여주는 대화상자
  void _showWinningNum(int lottoRoundNum) async {
    // 로또 값 받아오기
    lottoData = await getLottoResult(lottoRoundNum);

    // 성공적인 값 불러오기 여부 체크
    if (lottoData['returnValue'].toString() == 'success') {
      // 추첨 회차
      String drwNo = lottoData['drwNo'].toString();
      // 추첨 날짜
      String drwNoDate = lottoData['drwNoDate'].toString();
      // 총 상금
      String totSellamnt = lottoData['totSellamnt'].toString();
      // 1등 상금
      String firstWinamnt = lottoData['dfirstWinamnt'].toString();
      // 1등 당첨자 수
      String firstPrzwnerCo = lottoData['firstPrzwnerCo'].toString();

      showDialog(
        barrierDismissible: true, //  빈 곳을 눌렀을 때, 창이 닫히는 지
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$drwNo회",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 24),
                    ),
                    SizedBox(width: 10),
                    Text("당첨결과", style: TextStyle(fontSize: 24)),
                  ],
                ),
                Text(
                  "($drwNoDate 추첨)",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("총 상금액 : ", style: TextStyle(fontSize: 18)),
                    Text("$totSellamnt 원", style: TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("1등 상금액 : ", style: TextStyle(fontSize: 18)),
                    Text("$firstWinamnt 원", style: TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("1등 당첨자 : ", style: TextStyle(fontSize: 18)),
                    Text("$firstPrzwnerCo 명", style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 20),
                //_getWinningNum()
              ],
            ),
          );
        },
      );
    }
  }

  _getWinningNum() {
    List<int> lottoNum = [];

    for (var i = 1; i < 7; i++) {
      var num = i * 5;
      lottoNum.add(num);
    }

    // 배열 정렬
    lottoNum.sort();

    var json = jsonEncode({
      'drwtNo1': lottoNum[0],
      'drwtNo2': lottoNum[1],
      'drwtNo3': lottoNum[2],
      'drwtNo4': lottoNum[3],
      'drwtNo5': lottoNum[4],
      'drwtNo6': lottoNum[5],
    });

    return LottoBallWidget(data: jsonDecode(json));
  }

  void _launchURL(url) async {
    await canLaunchUrlString(url) // canLaunch 대신 canLaunchUrlString을 사용하자
        ? await launch(url)
        : throw 'Could not launch $url';
  }

  getLottoResult(var lottoRoundNum) async {
    var url = Uri.parse(
        'http://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$lottoRoundNum');
    http.Response response = await http.get(url);
    lottoData = jsonDecode(response.body);
    return lottoData;
  }
}
