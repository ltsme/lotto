import 'dart:convert';
import 'dart:developer';

import 'package:lotto/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:lotto/widgets/lotto_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Lotto 앱 메인 컬러
Color appMainColor = Colors.blue.shade400;

String zodiac = '';
String constella = '';
String msg = '';

class LottoTodayLucky extends StatefulWidget {
  final int yearStr, monthStr, dayStr;
  LottoTodayLucky(
      {super.key,
      required this.yearStr,
      required this.monthStr,
      required this.dayStr});

  @override
  State<LottoTodayLucky> createState() => _LottoTodayLucky();
}

class _LottoTodayLucky extends State<LottoTodayLucky> {
  @override
  void initState() {
    getZodiac();
    getConstella();
    getDate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LottoService>(builder: (context, lottoservice, child) {
      return Scaffold(
        appBar: AppBarWidget(context),
        body: SafeArea(
          child: SingleChildScrollView(
            // 작은 화면에서 아래 넘칠 경우 스크롤
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(msg),
              ],
            ),
          ),
        ),
      );
    });
  }

  void getZodiac() {
    switch (widget.yearStr % 12) {
      case 0:
        zodiac = '원숭이띠';
        break;
      case 1:
        zodiac = '닭띠';
        break;
      case 2:
        zodiac = '개띠';
        break;
      case 3:
        zodiac = '돼지띠';
        break;
      case 4:
        zodiac = '쥐띠';
        break;
      case 5:
        zodiac = '소띠';
        break;
      case 6:
        zodiac = '호랑이띠';
        break;
      case 7:
        zodiac = '토끼띠';
        break;
      case 8:
        zodiac = '용띠';
        break;
      case 9:
        zodiac = '뱀띠';
        break;
      case 10:
        zodiac = '말띠';
        break;
      case 11:
        zodiac = '양띠';
        break;

      default:
    }
    log("message -> ${widget.yearStr % 12}");
    log("zodiac = $zodiac");
  }

  void getConstella() {}

  Future getDate() async {
    var url = Uri.parse(
        'https://openapi.naver.com/v1/search/webkr.json?query=$zodiac오늘의운세&display=1');

    http.Response response = await http.get(
      url,
      headers: {
        "X-Naver-Client-Id": "n2rE3LFU92tc11751Q3r",
        "X-Naver-Client-Secret": "X2t8njWhHP"
      },
    );

    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);
    setState(() {
      msg = responseBody;
    });

    log(response.body);

    print('get_statusCode : $statusCode');
    //print('get_responseHeaders : $responseHeaders');
    print('get_responseBody : $responseBody'); // 한글을 위해
  }
}
