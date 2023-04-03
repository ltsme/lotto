import 'package:flutter/material.dart';

/// Miso 메인 색상
Color misoPrimaryColor = Color.fromARGB(255, 38, 103, 240);

class Miso extends StatefulWidget {
  const Miso({Key? key}) : super(key: key);

  @override
  _MisoState createState() => _MisoState();
}

class _MisoState extends State<Miso> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여줌
        children: [
          MisoFirstPage(),
          MisoSecondPage(),
          MisoThirdPage(),
          MisoFourthPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // 현재 보여주는 탭
        onTap: (newIndex) {
          print("selected newIndex : $newIndex");
          // 다른 페이지로 이동
          setState(() {
            currentIndex = newIndex;
          });
        },
        selectedItemColor: misoPrimaryColor, // 선택된 아이콘 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
        showSelectedLabels: false, // 선택된 항목 label 숨기기
        showUnselectedLabels: false, // 선택되지 않은 항목 label 숨기기
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.redeem), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}

/// 첫 번째 페이지
class MisoFirstPage extends StatelessWidget {
  const MisoFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: misoPrimaryColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      // 기기 높이의 %로 줘서 적절한 위치에 배치한다.
                      height: MediaQuery.of(context).size.height * 0.2),
                  Text(
                    "대한민국 1등 홈서비스\n미소를 만나보세요!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 38),

                  // 예약하기 버튼
                  GestureDetector(
                    onTap: () {
                      print("버튼 클릭");
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: misoPrimaryColor,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "예약하기",
                            style: TextStyle(
                              fontSize: 16,
                              color: misoPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 32,
                child: GestureDetector(
                  onTap: () {
                    print("서비스 상세정보 클릭 됨");
                  },
                  child: Container(
                    color: Colors.white.withOpacity(0.3),
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "서비스 상세정보",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 두 번째 페이지
class MisoSecondPage extends StatelessWidget {
  const MisoSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        // 기기 높이의 %로 줘서 적절한 위치에 배치한다.
                        height: MediaQuery.of(context).size.height * 0.15),
                    Text(
                      "예약내역",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 64),
                    Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: misoPrimaryColor,
                        ),
                        SizedBox(width: 8),
                        // 폰의 폭과 관계없이 텍스트를 언제나 한 줄로 보여주기
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown, // child의 최소 크기를 존중한다.
                            child: Text(
                              "예약된 서비스가 아직 없어요. 지금 예약해보세요!",
                              style:
                                  TextStyle(fontSize: 100), // 아무리 커도 한 줄로 보이게
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey),
                  ],
                ),
              ),
              Positioned(
                bottom: 18,
                left: 24,
                right: 24,
                child: GestureDetector(
                  onTap: () {
                    print("예약하기 클릭 됨");
                  },
                  child: Container(
                    width: double.infinity,
                    height: 58,
                    color: misoPrimaryColor,
                    alignment: Alignment.center,
                    child: Text(
                      "예약하기",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 세 번째 페이지
class MisoThirdPage extends StatelessWidget {
  const MisoThirdPage({Key? key}) : super(key: key);

  /// 세 번째 화면 배경 이미지 URL
  final String backgroundImgUrl =
      "https://i.ibb.co/rxzkRTD/146201680-e1b73b36-aa1e-4c2e-8a3a-974c2e06fa9d.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: misoPrimaryColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 배경 이미지
              Positioned(
                bottom: 0,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Image.network(backgroundImgUrl),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 64),

                  // 특정 부분만 bold 처리 위해 RichText 사용
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 28,
                        height: 1.5, // 줄간격 한 줄의 1.5배
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(text: "친구 추천할 때마다\n"),
                        TextSpan(
                            text: "10,000원 ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "할인 쿠폰 지급!"),
                      ],
                    ),
                  ),
                  SizedBox(height: 64),
                  GestureDetector(
                    onTap: () {
                      print("자세히 보기 클릭 됨");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "자세히보기",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Icon(Icons.chevron_right, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 42,
                child: GestureDetector(
                  onTap: () {
                    print("서비스 상세정보 클릭 됨");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(64),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          // 그림자 광원의 위치를 중심보다 위쪽 (0, 5133)
                          offset: Offset(0, 5),
                          spreadRadius: 1,
                          blurRadius: 12,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.redeem,
                          color: misoPrimaryColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "친구 추천하기",
                          style: TextStyle(
                            fontSize: 18,
                            color: misoPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
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
  }
}

/// 네 번째 페이지
class MisoFourthPage extends StatelessWidget {
  const MisoFourthPage({Key? key}) : super(key: key);

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
              SizedBox(height: 16),
              Text(
                "010-9999-9999",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              ListTile(
                onTap: () => print("주소 관리 클릭"),
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.home_outlined, color: Colors.black),
                title: Text(
                  "주소 관리",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                onTap: () => print("결제 수단 관리 클릭"),
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.credit_card_outlined, color: Colors.black),
                title: Text(
                  "결제 수단 관리",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
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
                  "문의사항",
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
