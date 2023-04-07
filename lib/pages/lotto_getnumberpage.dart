import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:lotto/widgets/lotto_ball.dart';
import 'package:flutter/material.dart';
import 'package:lotto/widgets/lotto_service.dart';
import 'package:provider/provider.dart';

// Lotto 앱 메인 컬러
Color appMainColor = Colors.blue.shade400;

class LottoGetNumberPage extends StatefulWidget {
  const LottoGetNumberPage({super.key});

  @override
  State<LottoGetNumberPage> createState() => _LottoLottoGetNumberPage();
}

class _LottoLottoGetNumberPage extends State<LottoGetNumberPage> {
  Widget textWidget = const Text(
    '# 여기를 눌러보세요!',
    style: TextStyle(color: Colors.black, fontSize: 20),
  );
  Widget textWidget2 = const Text(
    '# 여기를 눌러보세요!',
    style: TextStyle(color: Colors.black, fontSize: 20),
  );
  Widget textWidget3 = const Text(
    '# 여기를 눌러보세요!',
    style: TextStyle(color: Colors.black, fontSize: 20),
  );
  Widget textWidget4 = const Text(
    '# 여기를 눌러보세요!',
    style: TextStyle(color: Colors.black, fontSize: 20),
  );
  Widget textWidget5 = const Text(
    '# 여기를 눌러보세요!',
    style: TextStyle(color: Colors.black, fontSize: 20),
  );

  List<bool> bSwitch = [false, false, false, false, false];
  List<dynamic> lottogamesList = ['', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    return Consumer<LottoService>(builder: (context, lottoservice, child) {
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 35),
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
                      style:
                          TextStyle(color: Colors.blue.shade700, fontSize: 19),
                    ),
                    const TextSpan(
                      text: "/",
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    TextSpan(
                      text: "45",
                      style:
                          TextStyle(color: Colors.blue.shade700, fontSize: 19),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // title: Image.asset('assets/images/logo.png', height: 32),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            // 작은 화면에서 아래 넘칠 경우 스크롤
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300]),
                      onPressed: () {
                        if (bSwitch[0] == false) {
                          List<int> lottoNum = _getLottoNum();
                          lottogamesList[0] = lottoNum;
                          String json = _setLottoNum(lottoNum);

                          setState(() {
                            textWidget =
                                LottoBallWidget(data: jsonDecode(json));
                            bSwitch[0] = true;
                          });
                        } else {
                          _showDialog(context, lottogamesList[0]);
                        }
                      },
                      child: textWidget),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300]),
                      onPressed: () {
                        if (bSwitch[1] == false) {
                          List<int> lottoNum = _getLottoNum();
                          lottogamesList[1] = lottoNum;
                          String json = _setLottoNum(lottoNum);
                          setState(() {
                            textWidget2 =
                                LottoBallWidget(data: jsonDecode(json));
                            bSwitch[1] = true;
                          });
                        } else {
                          _showDialog(context, lottogamesList[1]);
                        }
                      },
                      child: textWidget2),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300]),
                      onPressed: () {
                        if (bSwitch[2] == false) {
                          List<int> lottoNum = _getLottoNum();
                          lottogamesList[2] = lottoNum;
                          String json = _setLottoNum(lottoNum);
                          setState(() {
                            textWidget3 =
                                LottoBallWidget(data: jsonDecode(json));
                            bSwitch[2] = true;
                          });
                        } else {
                          _showDialog(context, lottogamesList[2]);
                        }
                      },
                      child: textWidget3),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300]),
                      onPressed: () {
                        if (bSwitch[3] == false) {
                          List<int> lottoNum = _getLottoNum();
                          lottogamesList[3] = lottoNum;
                          String json = _setLottoNum(lottoNum);
                          setState(() {
                            textWidget4 =
                                LottoBallWidget(data: jsonDecode(json));
                            bSwitch[3] = true;
                          });
                        } else {
                          _showDialog(context, lottogamesList[3]);
                        }
                      },
                      child: textWidget4),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300]),
                      onPressed: () {
                        if (bSwitch[4] == false) {
                          List<int> lottoNum = _getLottoNum();
                          lottogamesList[4] = lottoNum;
                          String json = _setLottoNum(lottoNum);
                          setState(() {
                            textWidget5 =
                                LottoBallWidget(data: jsonDecode(json));
                            bSwitch[4] = true;
                          });
                        } else {
                          _showDialog(context, lottogamesList[4]);
                        }
                      },
                      child: textWidget5),
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
                AuthService authService = context.read<AuthService>();
                User? user = authService.currentUser()!;
                LottoService lottoService = context.read<LottoService>();

                //if(){              }else{                }
                lottoService.create(user.uid, lottogames);
                // var array = [];
                // var readRes =
                //     await storage.read(key: 'randomLotto');

                // if (readRes == null) {
                //   array.add(jsonDecode(json));
                // } else {
                //   array = jsonDecode(readRes);
                //   array.add(jsonDecode(json));
                // }

                // await storage.write(
                //     key: 'randomLotto', value: jsonEncode(array));

                // Get.back();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
