import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:lotto/widgets/lotto_ball.dart';
import 'package:lotto/widgets/lotto_service.dart';
import 'package:provider/provider.dart';

String dateToday = '';

class LottoMainPageLottolist extends StatefulWidget {
  const LottoMainPageLottolist({super.key});

  @override
  State<LottoMainPageLottolist> createState() => _LottoMainPageLottolistState();
}

class _LottoMainPageLottolistState extends State<LottoMainPageLottolist> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<LottoService>(builder: (contex, lottoservice, child) {
        // User 데이터를 받아 옴, Null은 불가능
        User user = context.read<AuthService>().currentUser()!;
        return Expanded(
          child: FutureBuilder<QuerySnapshot>(
            // CRUD의 Read
            future: lottoservice.read(user.uid),
            builder: (context, snapshot) {
              // 값이 있으면 docs 리스트, 없으면 [] (NULL 리스트) 형태로 값을 반환.
              final documents = snapshot.data?.docs ?? [];

              // 버킷 리스트가 비었을 경우
              if (documents.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.blue.shade300,
                        ),
                        const SizedBox(width: 8),
                        // 폰의 폭과 관계없이 텍스트를 언제나 한 줄로 보여주기
                        const Text(
                          "저장된 로또 리스트가 없어요 🤔",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black), // 아무리 커도 한 줄로 보이게
                        ),
                      ],
                    ),
                    const Divider(color: Colors.black),
                  ],
                );
              } else {
                // 버킷 리스트가 비지 않았을 경우
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final docs = documents[index];
                    List<dynamic> lottoGames = docs.get("lottogames");
                    String json = _setLottoNum(lottoGames);
                    dateToday = docs.get("date");

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const SizedBox(width: 12),
                            Text(
                              dateToday,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ListTile(
                          tileColor: Colors.grey.shade300,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          title: LottoBallWidget(data: jsonDecode(json)),
                          // 삭제 아이콘 버튼
                          trailing: IconButton(
                            icon: const Icon(CupertinoIcons.delete),
                            onPressed: () async {
                              // 삭제 버튼 클릭시 CRUD - Delete
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    insetPadding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    title: const Text(
                                      "저장된 번호를 삭제 할까요?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            // true가 전달되어, 리스트 삭제.
                                            lottoservice.delete(docs.id);
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text("예")),
                                      TextButton(
                                          onPressed: () {
                                            // false가 전달, 아무일도 일어나지 않음.
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text("아니오")),
                                    ],
                                  );
                                },
                              );
                            },
                          ),

                          onTap: () {
                            // 저장된 내역 클릭 시
                            print("리스트 클릭!");
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        );
      }),
    );
  }

  _setLottoNum(List<dynamic> lottoNum) {
    var json = jsonEncode({
      'drwtNo1': lottoNum[0],
      'drwtNo2': lottoNum[1],
      'drwtNo3': lottoNum[2],
      'drwtNo4': lottoNum[3],
      'drwtNo5': lottoNum[4],
      'drwtNo6': lottoNum[5],
    });

    return json;
  }
}
