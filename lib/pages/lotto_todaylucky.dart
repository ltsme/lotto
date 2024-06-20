import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:lotto/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:lotto/widgets/lotto_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Lotto 앱 메인 컬러
Color appMainColor = Colors.blue.shade400;

String zodiac = '';
String yearStr = '';
String msg = '';
String img = '';

class LottoTodayLucky extends StatefulWidget {
  final int yearStr, monthStr;
  const LottoTodayLucky(
      {super.key, required this.yearStr, required this.monthStr});

  @override
  State<LottoTodayLucky> createState() => _LottoTodayLucky();
}

class _LottoTodayLucky extends State<LottoTodayLucky> {
  @override
  void initState() {
    getYearStr(); // ~년생
    getZodiac(); // ~띠
    getDate();

    super.initState();
  }

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
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/$img.png",
                    width: context.width,
                    height: context.width * 0.4,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "$yearStr년생 $zodiac",
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(height: 8),
                Text(msg),
              ],
            ),
          ),
        ),
      );
    });
  }

  void getYearStr() {
    String TmpYearStr = widget.yearStr.toString();
    yearStr = TmpYearStr.substring(TmpYearStr.length - 2);
  }

  void getZodiac() {
    switch (widget.yearStr % 12) {
      case 0:
        zodiac = '원숭이띠';
        img = 'zodiac_monkey';
        break;
      case 1:
        zodiac = '닭띠';
        img = 'zodiac_chick';
        break;
      case 2:
        zodiac = '개띠';
        img = 'zodiac_dog';
        break;
      case 3:
        zodiac = '돼지띠';
        img = 'zodiac_pig';
        break;
      case 4:
        zodiac = '쥐띠';
        img = 'zodiac_rat';
        break;
      case 5:
        zodiac = '소띠';
        img = 'zodiac_cow';
        break;
      case 6:
        zodiac = '호랑이띠';
        img = 'zodiac_tiger';
        break;
      case 7:
        zodiac = '토끼띠';
        img = 'zodiac_rabbit';
        break;
      case 8:
        zodiac = '용띠';
        img = 'zodiac_dragon';
        break;
      case 9:
        zodiac = '뱀띠';
        img = 'zodiac_snake';
        break;
      case 10:
        zodiac = '말띠';
        img = 'zodiac_horse';
        break;
      case 11:
        zodiac = '양띠';
        img = 'zodiac_sheep';
        break;

      default:
    }
    log("message -> ${widget.yearStr % 12}");
    log("zodiac = $zodiac");
  }

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

    if (response.statusCode == 200) {
      // JSON 응답 파싱
      final Map<String, dynamic> data = json.decode(response.body);
      log('MappedData : $data');
      final items = data['items'] as List<dynamic>;
      log('items : $items');
      if (items.isNotEmpty) {
        setState(() {
          msg = items[0]['description'];
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
