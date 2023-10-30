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
              SizedBox(
                width: double.infinity, // 가득 채우기
                child: Column(
                  children: [
                    /// 동그란 배경
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                        /// 이미지
                        child: Image.network(
                          "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                          width: 62,
                        ),
                      ),
                    ),

                    /// 닉네임 상단 여백
                    SizedBox(height: 16),

                    /// 닉네임
                    Text(
                      //"닉네임 : ${widget.uid}",
                      "Nickname",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),

                    /// 이메일
                    Text(
                      "hello@world.com",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
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
