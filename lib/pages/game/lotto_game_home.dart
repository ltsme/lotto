import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game1/src/widgets/lotto_game1.dart';
import 'package:lotto/pages/game/game2/lotto_game2.dart';
import 'package:lotto/widgets/appbar.dart';

class LottoGameHome extends StatelessWidget {
  const LottoGameHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 게임 1 텍스트
            RichText(
              text: const TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: "게임 ", style: TextStyle(color: Colors.green)),
                  TextSpan(text: "1"),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // 게임 1 이미지 버튼
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LottoGameOne()),
              ),
              child: Container(
                width: (MediaQuery.of(context).size.width) * 0.9,
                height: (MediaQuery.of(context).size.height) * 0.2,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: const Text('게임 1'),
              ),
            ),
            const SizedBox(height: 24),
            // 게임 2 텍스트
            RichText(
              text: const TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: "게임 ",
                    style: TextStyle(color: Colors.green),
                  ),
                  TextSpan(text: "2"),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // 게임 2 이미지 버튼
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LottoGameTwo()),
              ),
              child: Container(
                width: (MediaQuery.of(context).size.width) * 0.9,
                height: (MediaQuery.of(context).size.height) * 0.2,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: const Text('게임 2'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
