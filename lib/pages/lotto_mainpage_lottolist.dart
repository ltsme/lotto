import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LottoMainPageLottolist extends StatefulWidget {
  const LottoMainPageLottolist({super.key});

  @override
  State<LottoMainPageLottolist> createState() => _LottoMainPageLottolistState();
}

class _LottoMainPageLottolistState extends State<LottoMainPageLottolist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: willPopScope,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }

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
                child: Text("예")),
            ElevatedButton(
                onPressed: () {
                  // false가 전달되어 앱이 종료 되지 않음
                  Navigator.pop(context, false);
                },
                child: Text("아니오")),
          ],
        );
      },
    );
  }
}
