import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lotto/pages/lotto_getnumberpage.dart';
import 'package:lotto/widgets/LoadingPage.dart';
import 'package:lotto/widgets/lotto_ball.dart';
import 'package:lotto/widgets/qrscan.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

// Lotto 앱 메인 컬러
Color appMainColor = Colors.blue.shade400;

//포인트 색상
Color accentColor = const Color.fromARGB(255, 199, 176, 121);

// 오늘 날짜
var nowDate = DateTime.now();
// 오늘 기준 토요일
var saterdayDate =
    DateTime(nowDate.year, nowDate.month, nowDate.day + (7 - nowDate.weekday));
// D-day
var dDayDate = saterdayDate.difference(nowDate);

class LottoMainPageHome extends StatefulWidget {
  const LottoMainPageHome({super.key});

  @override
  State<LottoMainPageHome> createState() => _LottoMainPageHome();
}

class _LottoMainPageHome extends State<LottoMainPageHome> {
  // Lotto API 데이터
  var thisRoundDrwNo = 1060; // 임시로 상수 사용, 이후 계산 가능하게 업데이트
  var lottoData;
  var thisRoundLottoData;

  // 로또 데이터 맵
  Map<String, String> lottoDataMap = {
    "drwNo": "",
    "drwNoDate": "",
    "toSellamnt": "",
    "firstWinamnt": "",
    "firstPrzwnerCo": "",
  };

  // 이번 회차 로또 번호 리스트
  List<int> thisLottoNumList = const [];
  // 로또 번호 리스트
  List<int> lottoNumList = const [];

  @override
  void initState() {
    getLottoDataInit(thisRoundDrwNo);
    super.initState();
  }

  getLottoDataInit(var lottoRoundNum) async {
    var url = Uri.parse(
        'http://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$lottoRoundNum');
    http.Response response = await http.get(url);
    // 서버 연결 성공 시 변수에 값을 집어넣음
    if (response.statusCode == 200) {
      setState(() {
        thisRoundLottoData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Fail');
    }
  }

  String naverUrl =
      'https://m.search.naver.com/search.naver?sm=mtp_hty.top&where=m&query=%EB%84%A4%EC%9D%B4%EB%B2%84+%EC%9A%B4%EC%84%B8';

  /// 배경 이미지 URL
  final String titleImg = "assets/images/lotto_title.png";

  final textController = TextEditingController();
  final dialogController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    // 비동기 로딩 화면
    return thisRoundLottoData == null
        ? const LoadingPage()
        : Scaffold(
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
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Row(
                                //   children: [
                                //     const Icon(
                                //       Icons.arrow_circle_up_sharp,
                                //       size: 24.0,
                                //       color: Colors.black,
                                //     ),
                                //     TextButton(
                                //       onPressed: () {},
                                //       child: const Text(
                                //         '위로 돌아가기',
                                //         style: TextStyle(
                                //           fontSize: 18,
                                //           color: Colors.black,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Row(
                                  children: [
                                    const Text(
                                      "이번 추첨일 까지 / ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      // 삼항 연산자를 이용해 당일인 경우 0, 나머지는 차이만큼 표시
                                      "- ${dDayDate.inDays == 0 ? "0" : dDayDate.inDays}일",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ],
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 광고 그림 위젯
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 20, vertical: 12),
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(8),
                            //     child: Image.asset('assets/images/advertise_image.png'),
                            //   ),
                            // ),

                            // 이번 회차 당첨번호 텍스트
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(text: "이번 회차 "),
                                    TextSpan(
                                      text: "당첨 번호 ",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    TextSpan(
                                        text:
                                            " (${thisRoundLottoData['drwNoDate']})"),
                                  ],
                                ),
                              ),
                            ),
                            // 이번 회차 당첨번호 위젯

                            _setWinningNum(thisRoundLottoData),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 이번 회차 당첨번호
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
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
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                width: 400,
                                height: 1000,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
    textController.text = '$thisRoundDrwNo';
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
                "(이번 회차는 $thisRoundDrwNo회 입니다.)",
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                      decoration: const InputDecoration(counterText: ''),
                    ),
                  ),
                  const Text(" 회"),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.amber),
                  controller: dialogController,
                  enabled: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("취소"),
              onPressed: () {
                Navigator.pop(context);
                textController.text = '$thisRoundDrwNo';
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
                  Navigator.pop(context);
                  _showWinningNum(
                    int.parse(textController.text),
                  );
                  textController.text = '$thisRoundDrwNo';
                  dialogController.text = '';
                }
              },
            ),
          ],
        );
      },
    );
  }

  // 당첨 회차 보여주는 대화상자
  void _showWinningNum(int receivedRoundNum) async {
    await getLottoData(receivedRoundNum);

    // 성공적인 값 불러오기 여부 체크
    if (lottoData['returnValue'].toString() == 'success') {
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
                      "${lottoData['drwNo']}회",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 24),
                    ),
                    SizedBox(width: 10),
                    Text("당첨결과", style: TextStyle(fontSize: 24)),
                  ],
                ),
                Text(
                  "(${lottoData['drwNoDate']} 추첨)",
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
                    Text("${lottoData['totSellamnt']} 원",
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("1등 상금액 : ", style: TextStyle(fontSize: 18)),
                    Text("${lottoData['firstWinamnt']} 원",
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("1등 당첨자 : ", style: TextStyle(fontSize: 18)),
                    Text("${lottoData['firstPrzwnerCo']} 명",
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 20),
                _setWinningNum(lottoData)
              ],
            ),
          );
        },
      );
    }
  }

  // 회차번호를 받아 lottoData에 넣는 메소드
  getLottoData(var lottoRoundNum) async {
    var url = Uri.parse(
        'http://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$lottoRoundNum');
    http.Response response = await http.get(url);
    // 서버 연결 성공 시 변수에 값을 집어넣음
    if (response.statusCode == 200) {
      setState(() {
        lottoData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Fail');
    }
  }

  _setWinningNum(var lottoData) {
    var json = jsonEncode({
      'drwtNo1': lottoData['drwtNo1'],
      'drwtNo2': lottoData['drwtNo2'],
      'drwtNo3': lottoData['drwtNo3'],
      'drwtNo4': lottoData['drwtNo4'],
      'drwtNo5': lottoData['drwtNo5'],
      'drwtNo6': lottoData['drwtNo6'],
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LottoBallWidget(data: jsonDecode(json)),
    );
  }

  void _launchURL(url) async {
    await canLaunchUrlString(url) // canLaunch 대신 canLaunchUrlString을 사용하자
        ? await launch(url)
        : throw 'Could not launch $url';
  }
}
