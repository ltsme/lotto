import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:lotto/widgets/lotto_ball.dart';
import 'package:flutter/material.dart';
import 'package:lotto/widgets/lotto_service.dart';
import 'package:provider/provider.dart';

import '../widgets/appbar.dart';

// Lotto 앱 메인 컬러
Color appMainColor = Colors.blue.shade400;

Text lottoWidgetCover = const Text(
  '여기를 눌러보세요!',
  style: TextStyle(color: Colors.black, fontSize: 20),
);

String dateToday = '';

class LottoGetNumberPage extends StatefulWidget {
  const LottoGetNumberPage({super.key});

  @override
  State<LottoGetNumberPage> createState() => _LottoLottoGetNumberPage();
}

class _LottoLottoGetNumberPage extends State<LottoGetNumberPage> {
  List<Widget> lottoWidget = [
    lottoWidgetCover,
    lottoWidgetCover,
    lottoWidgetCover,
    lottoWidgetCover,
    lottoWidgetCover,
  ];
  final List<bool> _visibility = [true, false, false, false, false];
  bool _visibleBtn = false;
  List<dynamic> lottogamesList = ['', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Consumer<LottoService>(builder: (context, lottoservice, child) {
      return Scaffold(
        appBar: appBarWidget(context),
        body: SafeArea(
          child: SingleChildScrollView(
            // 작은 화면에서 아래 넘칠 경우 스크롤
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // lottoWidget1
                Visibility(
                  visible: _visibility[0],
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[300]),
                        onPressed: () {
                          if (lottoWidget[0] != lottoWidgetCover) {
                            _showDialog(context, lottogamesList[0]);
                          } else {
                            List<int> lottoNum = _getLottoNum();
                            lottogamesList[0] = lottoNum;
                            String json = _setLottoNum(lottoNum);

                            setState(() {
                              lottoWidget[0] =
                                  LottoBallWidget(data: jsonDecode(json));
                              _visibility[1] = true;
                            });
                          }
                        },
                        child: lottoWidget[0]),
                  ),
                ),
                // lottoWidget2
                Visibility(
                  visible: _visibility[1],
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[300]),
                        onPressed: () {
                          if (lottoWidget[1] != lottoWidgetCover) {
                            _showDialog(context, lottogamesList[1]);
                          } else {
                            List<int> lottoNum = _getLottoNum();
                            lottogamesList[1] = lottoNum;
                            String json = _setLottoNum(lottoNum);
                            setState(() {
                              lottoWidget[1] =
                                  LottoBallWidget(data: jsonDecode(json));
                              _visibility[2] = true;
                            });
                          }
                        },
                        child: lottoWidget[1]),
                  ),
                ),
                // lottoWidget3
                Visibility(
                  visible: _visibility[2],
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[300]),
                        onPressed: () {
                          if (lottoWidget[2] != lottoWidgetCover) {
                            _showDialog(context, lottogamesList[2]);
                          } else {
                            List<int> lottoNum = _getLottoNum();
                            lottogamesList[2] = lottoNum;
                            String json = _setLottoNum(lottoNum);
                            setState(() {
                              lottoWidget[2] =
                                  LottoBallWidget(data: jsonDecode(json));
                              _visibility[3] = true;
                            });
                          }
                        },
                        child: lottoWidget[2]),
                  ),
                ),
                // lottoWidget4
                Visibility(
                  visible: _visibility[3],
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[300]),
                        onPressed: () {
                          if (lottoWidget[3] != lottoWidgetCover) {
                            _showDialog(context, lottogamesList[3]);
                          } else {
                            List<int> lottoNum = _getLottoNum();
                            lottogamesList[3] = lottoNum;
                            String json = _setLottoNum(lottoNum);
                            setState(() {
                              lottoWidget[3] =
                                  LottoBallWidget(data: jsonDecode(json));
                              _visibility[4] = true;
                            });
                          }
                        },
                        child: lottoWidget[3]),
                  ),
                ),
                // lottoWidget5
                Visibility(
                  visible: _visibility[4],
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[300]),
                        onPressed: () {
                          if (lottoWidget[4] != lottoWidgetCover) {
                            _showDialog(context, lottogamesList[4]);
                          } else {
                            List<int> lottoNum = _getLottoNum();
                            lottogamesList[4] = lottoNum;
                            String json = _setLottoNum(lottoNum);
                            setState(() {
                              lottoWidget[4] =
                                  LottoBallWidget(data: jsonDecode(json));
                              _visibleBtn = true;
                            });
                          }
                        },
                        child: lottoWidget[4]),
                  ),
                ),

                // 다시 뽑기 버튼
                Visibility(
                  visible: _visibleBtn,
                  child: Center(
                    child: TextButton(
                      style: TextButton.styleFrom(),
                      onPressed: () {
                        for (int i = 1; i < _visibility.length; i++) {
                          _visibility[0] = true;
                          _visibility[i] = false;
                        }
                        setState(() {
                          for (int i = 0; i < lottoWidget.length; i++) {
                            lottoWidget[i] = lottoWidgetCover;
                          }
                          _visibleBtn = false;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.recycling, size: 24),
                          SizedBox(width: 8),
                          Text(
                            "다시 뽑기",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // List<int> 형태의 lottoNum 반환
  _getLottoNum() {
    List<int> lottoNum = [];
    for (var i = 0; i < 6; i++) {
      var lotto = Random().nextInt(45) + 1;
      lottoNum.contains(lotto) ? i-- : lottoNum.add(lotto);
    }

    // 배열 정렬
    lottoNum.sort();

    return lottoNum;
  }

  // var 형태의 json 반환
  _setLottoNum(List<dynamic> lottoNum) {
    var json = jsonEncode({
      'drwtNo1': lottoNum[0],
      'drwtNo2': lottoNum[1],
      'drwtNo3': lottoNum[2],
      'drwtNo4': lottoNum[3],
      'drwtNo5': lottoNum[4],
      'drwtNo6': lottoNum[5],
    });

    return json;
  }

  // 뒤로가기 버튼 이벤트
  willPopScope() {
    List<Widget> lottoWidget = [
      lottoWidgetCover,
      lottoWidgetCover,
      lottoWidgetCover,
      lottoWidgetCover,
      lottoWidgetCover,
    ];
    return 0;
  }

  // 번호 저장 다이얼로그
  _showDialog(BuildContext context, List<int> lottogames) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: const Text(
            '내 리스트에 저장 할까요?',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: const Text("취소"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("저장"),
              onPressed: () async {
                // 오늘의 날짜 받아오기
                DateTime now = DateTime.now();
                DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                dateToday = dateFormat.format(now);

                AuthService authService = context.read<AuthService>();
                User? user = authService.currentUser()!;
                LottoService lottoService = context.read<LottoService>();

                lottoService.create(
                  user.uid,
                  lottogames,
                  dateToday,
                );
                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                      title: const Text(
                        '저장 되었습니다.',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                          child: const Text("확인"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
