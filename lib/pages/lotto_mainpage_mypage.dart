import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LottoMainPageMyPage extends StatefulWidget {
  const LottoMainPageMyPage({super.key});

  @override
  State<LottoMainPageMyPage> createState() => _LottoMainPageMyPageState();
}

class _LottoMainPageMyPageState extends State<LottoMainPageMyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: willPopScope,
        child: SafeArea(
          child: SingleChildScrollView(
            // 작은 화면에서 아래 넘칠 경우 스크롤
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 62),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "나의 정보",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                ListTile(
                  onTap: () => print("공지사항 클릭"),
                  contentPadding: EdgeInsets.all(0),
                  leading:
                      Icon(Icons.volume_mute_outlined, color: Colors.black),
                  title: Text(
                    "공지사항",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                ListTile(
                  onTap: () => print("문의사항 클릭"),
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(Icons.help_outline, color: Colors.black),
                  title: Text(
                    "버그 신고하기",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
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
