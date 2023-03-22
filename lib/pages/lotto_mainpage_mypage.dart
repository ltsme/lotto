import 'package:flutter/material.dart';

class LottoMainPageMyPage extends StatelessWidget {
  const LottoMainPageMyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                leading: Icon(Icons.volume_mute_outlined, color: Colors.black),
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
    );
  }
}
