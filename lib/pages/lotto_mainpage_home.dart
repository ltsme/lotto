import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lotto/pages/game/lotto_game_home.dart';
import 'package:lotto/pages/lotto_naver_map.dart';
import 'package:lotto/pages/lotto_todaylucky.dart';
import 'package:lotto/widgets/loading_page.dart';
import 'package:lotto/widgets/lotto_ball.dart';
import 'package:lotto/widgets/qrscan.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;
import 'lotto_getnumberpage.dart';

// Lotto 앱 메인 컬러
Color appMainColor = Colors.blue.shade300;

// Lotto 앱 메인 Background 컬러
Color appBackColor = Colors.white;

//포인트 색상
Color accentColor = Colors.green.shade300;

// 오늘 날짜 nowDate
DateTime nowDate = DateTime.now();

// 오늘 기준 토요일 saterdayDate
var saterdayDate =
    DateTime(nowDate.year, nowDate.month, nowDate.day + (7 - nowDate.weekday));

// 이벤트 Asset
const String eventImg = "assets/images/advertise_image.png";

// 로또 번호 뽑기 그림
const String lottoimg1 = "assets/images/icon_game.png";
const String lottoimg2 = "assets/images/icon_picklottery.png";

// Kakao Api JavaScript 키
var kakaoMapKey = '953fcd9b73a5574241b4e6185312b34d';

// Lotto API 데이터
final difDays = DateTime.now()
    .difference(DateTime(2023, 01, 07))
    .inDays; // 1049회, 2023-01-07 기준
final difWeek = (difDays / 7).floor();
final int thisRoundDrwNo = 1049 + difWeek;

// 추첨일 당일
var thisRoundlottoData;

double posLat = 0.0;
double posLon = 0.0;

bool mapPermission = false;
String testPermissiion = '';

class LottoMainPageHome extends StatefulWidget {
  const LottoMainPageHome({super.key});

  @override
  State<LottoMainPageHome> createState() => _LottoMainPageHome();
}

class _LottoMainPageHome extends State<LottoMainPageHome> {
  // 오늘 부터 토요일 까지의 D-day
  var dDayDate = saterdayDate.difference(nowDate);

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

  final textController = TextEditingController();
  final textControllerY = TextEditingController();
  final textControllerM = TextEditingController();
  final dialogController = TextEditingController(text: '');
  final dialogController2 = TextEditingController(text: '');

  // createState()로 State 객체가 생성 된 후 initState()가 호출
  // 처음 한번만 호출 된다.
  @override
  void initState() {
    log('initState');
    getLottoData(thisRoundDrwNo);
    super.initState();
  }

  // initState() 함수가 호출된 뒤 바로 호출되는 함수.
  // 상속 관계에서 의존하는 위젯이 변경되면 호출.

  @override
  void didChangeDependencies() {
    log('didChangeDependencies');
    super.didChangeDependencies();
  }

  // 부모 위젯이나 데이터가 변경되어 위젯을 갱신해야 할 때 호출합니다.
  // initState() 함수는 위젯을 초기화할 때 한 번만 호출되므로 위젯이 변경되었을 때 호출하는 didUpdateWidget() 같은 함수가 필요합니다.
  @override
  void didUpdateWidget(covariant LottoMainPageHome oldWidget) {
    log('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // 비동기 로딩 화면, LottoData와 지도 데이터가 둘 다 있을 때
    return thisRoundlottoData == null
        ? const LoadingPage()
        : Scaffold(
            // 전체 Background Color 설정
            backgroundColor: appBackColor,
            // 뒤로가기 종료 기능을 위한 WillPopScope 위젯
            body: Stack(
              // 우측 하단에 플로팅 '로또 번호 뽑기' 아이콘 띄우기 위해 Stack으로 구현
              children: [
                // Sliver 위젯을 이용하기 위해 CustomScrollView를 사용.
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      // SliverAppBar Background Color 설정
                      backgroundColor: Colors.blue.shade100,
                      automaticallyImplyLeading: false, // App Bar에서 뒤로가기 버튼 숨기기
                      pinned: true, // 스크롤 시 bottom 영역을 고정할 지
                      snap: false, // 중간에 멈출 때 자동으로 AppBar를 펼쳐서 보여줄지
                      floating: true, // AppBar를 화면에 띄울지, 아니면 컬럼처럼 최 상단에 놓을 지
                      expandedHeight: 150,

                      // --! 스크롤 시 사라질 영역, flexibleSpace
                      flexibleSpace: Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Stack(
                            children: [
                              // 백 그라운드 이미지
                              Positioned(
                                left: 24,
                                right: 24,
                                top: 36,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "로또 앱과 함께 \n 1등까지! 🍀",
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
                      ),
                      // --! 스크롤 시 남아있는 영역, bottom
                      // SliverAppBar의 bottom은 PrefereedSize 위젯으로 시작해야만 한다.
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(40), // 영역의 높이
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "다음 추첨일 까지 / ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    // 삼항 연산자를 이용해 당일인 경우, 나머지는 차이만큼 표시
                                    //"- ${dDayDate.inDays == 0 ? "0" : dDayDate.inDays}일",
                                    "${DateTime.parse(thisRoundlottoData['drwNoDate']).day + 7 - nowDate.day}일",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // CustomScrollView 안에서는 모든 첫 번째 위젯이 Sliver로 구현 되어야한다.
                    // SliverToBoxAdapter는 Container와 같은 위젯으로 생각하자.
                    SliverToBoxAdapter(
                      // 메인화면 Body 부분 메인 Padding
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // 기능 1. QR 코드 스캔
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const QrScan(),
                                            ),
                                          );
                                        },
                                        icon: Image.asset(
                                          'assets/images/icon_qr.png',
                                          width: 80,
                                          height: 80,
                                        ),
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
                                          'assets/images/icon_lottery.png',
                                          width: 80,
                                          height: 80,
                                        ),
                                        tooltip: '당첨번호 확인',
                                      ),
                                      const Text('당첨번호 확인')
                                    ],
                                  ),
                                  // 기능 3. 오늘의 운세
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _todayLuckyDialog();
                                        },
                                        icon: Image.asset(
                                          'assets/images/icon_clover.png',
                                          width: 80,
                                          height: 80,
                                        ),
                                        tooltip: '오늘의 운세',
                                      ),
                                      const Text('오늘의 운세')
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // 이번 회차 당첨번호
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    const TextSpan(text: "이번 회차 "),
                                    const TextSpan(
                                      text: "당첨 번호 ",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    TextSpan(
                                      text:
                                          " (${thisRoundlottoData['drwNoDate']}, $thisRoundDrwNo회)",
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // 이번 회차 당첨번호 위젯
                            _setWinningNum(thisRoundlottoData),

                            const SizedBox(height: 16),

                            // 카카오 지도 띄우기
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                      fontSize: 16,
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
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LottoNaverMap(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_map.png',
                                      width: 60,
                                    ),
                                    const Text('주변 찾아보기')
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            // 광고
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(eventImg),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Deliverys 위젯 추가 위해 Stack 위젯으로 감싼다.
                // 기능 4. 로또 번호 뽑기 버튼
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      _getLottoNumDialog();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: appMainColor,
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "로또 번호 뽑기",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Image.asset('assets/images/lottoball.png', width: 36),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  } // build

  // 메인화면에서 뒤로가기 클릭 시 종료 다이얼로그
  Future<bool> willPopScope() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: const Text("앱을 종료하시겠습니까?"),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  // true가 전달되어 앱이 종료 됨.
                  SystemNavigator.pop();
                },
                child: const Text("예")),
            ElevatedButton(
                onPressed: () {
                  // false가 전달되어 앱이 종료 되지 않음
                  Navigator.pop(context, false);
                },
                child: const Text("아니오")),
          ],
        );
      },
    );
  }

  // 회차 번호 입력하는 Dialog 생성 메소드
  void _winningNumDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //  빈 곳을 눌렀을 때, 창이 닫히는 지
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
                      textAlign: TextAlign.center,
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
              TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.amber),
                controller: dialogController,
                enabled: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
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
                  Navigator.pop(context);
                  showWinningNum(
                    int.parse(textController.text),
                  );
                  textController.text = '';
                  dialogController.text = '';
                }
              },
            ),
          ],
        );
      },
    );
  }

  // 로또 번호 뽑는 방법 묻는 Dialog 생성 메소드
  void _getLottoNumDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //  빈 곳을 눌렀을 때, 창이 닫히는 지
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 8),
          title: const SizedBox(height: 8),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // -----기능 4_1 로또 게임 페이지 이동
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LottoGameHome(),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      lottoimg1,
                      width: (MediaQuery.of(context).size.width) * 0.2,
                      height: (MediaQuery.of(context).size.width) * 0.15,
                    ),
                    const SizedBox(height: 16),
                    const Text("게임으로 번호 뽑기"),
                  ],
                ),
              ),
              const SizedBox(width: 24),

              // -----기능 4_2 로또 번호 추출 페이지 이동
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LottoGetNumberPage(),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      lottoimg2,
                      width: (MediaQuery.of(context).size.width) * 0.2,
                      height: (MediaQuery.of(context).size.width) * 0.15,
                    ),
                    const SizedBox(height: 16),
                    const Text("그냥 번호 뽑기"),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                "취소",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // 회차 별 당첨 점보 보여주는 Dialog 생성 메소드
  void showWinningNum(int roundNum) async {
    var url = Uri.parse(
        'http://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$roundNum');
    http.Response response = await http.get(url);
    var lottoData = jsonDecode(response.body);

    // 천단위 출력을 위한 포맷
    var f = NumberFormat('###,###,###,###');

    if (response.statusCode == 200) {
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
                      style: const TextStyle(color: Colors.red, fontSize: 32),
                    ),
                    const SizedBox(width: 10),
                    const Text("당첨결과", style: TextStyle(fontSize: 32)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "(${lottoData['drwNoDate']} 추첨)",
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
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
                    const Text("총 상금액 : ", style: TextStyle(fontSize: 18)),
                    Text("${f.format(lottoData['totSellamnt'])} 원",
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey[600])),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("1등 상금액 : ", style: TextStyle(fontSize: 18)),
                    Text("${f.format(lottoData['firstWinamnt'])} 원",
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey[600])),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("1등 당첨자 : ", style: TextStyle(fontSize: 18)),
                    Text("${lottoData['firstPrzwnerCo']} 명",
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey[600])),
                  ],
                ),
                const SizedBox(height: 20),
                _setWinningNum(lottoData),
              ],
            ),
          );
        },
      );
    } else {
      throw Exception('Fail');
    }
  }

  // 오늘의 운세 다이얼로그
  void _todayLuckyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //  빈 곳을 눌렀을 때, 창이 닫히는 지
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Column(
            children: const [
              Text(
                '생년월일을 입력해 주세요!',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 50,
                    height: 20,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: textControllerY,
                      maxLength: 4,
                      enabled: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(counterText: ''),
                    ),
                  ),
                  const Text("년"),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 30,
                    height: 20,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: textControllerM,
                      maxLength: 2,
                      enabled: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(counterText: ''),
                    ),
                  ),
                  const Text("월"),
                ],
              ),
              TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.amber),
                controller: dialogController2,
                enabled: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("취소"),
              onPressed: () {
                Navigator.pop(context);
                textControllerY.text = '';
                textControllerM.text = '';
                dialogController2.text = '';
              },
            ),
            TextButton(
              child: const Text("확인"),
              onPressed: () {
                if (textControllerY.text.isEmpty) {
                  setState(() {
                    dialogController2.text = '년도를 확인해 주세요!';
                  });
                } else if (textControllerM.text.isEmpty) {
                  setState(() {
                    dialogController2.text = '월을 확인해 주세요!';
                  });
                } else {
                  int year = int.parse(textControllerY.text);
                  int month = int.parse(textControllerM.text);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LottoTodayLucky(yearStr: year, monthStr: month)),
                  );
                  textControllerY.text = '';
                  textControllerM.text = '';
                  dialogController2.text = '';
                }
              },
            ),
          ],
        );
      },
    );
  }

  // ----------------------- 메소드 ------------------------------

  // 회차번호를 받아 로또 데이터를 리턴하는 메소드
  getLottoData(int thisRoundDrwNo) async {
    log("getLottoData 메소드 시작");
    var url = Uri.parse(
        'http://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$thisRoundDrwNo');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // 당일인 경우, 데이터가 비어 있으므로 전회차로 계산
      thisRoundlottoData = jsonDecode(response.body);
      if (thisRoundlottoData['returnValue'] == "fail") {
        log("전 회차 데이터 불러오기");
        var url = Uri.parse(
            'http://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=${thisRoundDrwNo - 1}');
        http.Response response = await http.get(url);
        setState(() {
          thisRoundlottoData = jsonDecode(response.body);
        });
      } else {
        log("이번 회차 데이터 그대로 쓰기");
        setState(() {
          thisRoundlottoData = jsonDecode(response.body);
        });
      }
    } else {
      throw Exception('Fail');
    }
  }

  _setWinningNum(var lottoData) {
    log("setWinningNum 메소드 시작");
    var json = jsonEncode({
      'drwtNo1': lottoData['drwtNo1'],
      'drwtNo2': lottoData['drwtNo2'],
      'drwtNo3': lottoData['drwtNo3'],
      'drwtNo4': lottoData['drwtNo4'],
      'drwtNo5': lottoData['drwtNo5'],
      'drwtNo6': lottoData['drwtNo6'],
    });

    return LottoBallWidget(data: jsonDecode(json));
  }

  void _launchURL(url) async {
    await canLaunchUrlString(url) // canLaunch 대신 canLaunchUrlString을 사용하자
        ? await launch(url)
        : throw 'Could not launch $url';
  }
}
