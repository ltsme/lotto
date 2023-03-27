import 'package:flutter/material.dart';

// 비 동기 상황에서 로딩 페이지 로드
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}
