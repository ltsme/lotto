import 'dart:convert';
import 'dart:math';
import 'package:lotto/widgets/lotto_ball.dart';
import 'package:flutter/material.dart';

class LottoGetNumberPage extends StatefulWidget {
  const LottoGetNumberPage({super.key});

  @override
  State<LottoGetNumberPage> createState() => _LottoLottoGetNumberPage();
}

class _LottoLottoGetNumberPage extends State<LottoGetNumberPage> {
  void _abc(String json) {
    setState(() {
      textWidget = LottoBallWidget(data: jsonDecode(json));
    });
  }

  Widget textWidget = const Text(
    '# 여기를 눌러보세요!',
    style: TextStyle(color: Colors.black, fontSize: 20),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.grey[300]),
                    onPressed: () {
                      List<int> lottoNum = [];

                      for (var i = 0; i < 6; i++) {
                        var lotto = Random().nextInt(45) + 1;
                        lottoNum.contains(lotto) ? i-- : lottoNum.add(lotto);
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

                      _abc(json);

                      //Dialog 생성
                      //_showDialog(context, json);
                    },
                    child: textWidget),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getLottoNum() {}

  _showDialog(BuildContext context, var json) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: const Text(
            '행운의 추천번호 !!!\n',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          content: LottoBallWidget(data: jsonDecode(json)),
          actions: [
            TextButton(
              child: const Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("번호 저장"),
              onPressed: () async {
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
              },
            ),
          ],
        );
      },
    );
  }
}
