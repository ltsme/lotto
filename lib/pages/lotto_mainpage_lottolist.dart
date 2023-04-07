import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:lotto/widgets/lotto_ball.dart';
import 'package:lotto/widgets/lotto_service.dart';
import 'package:provider/provider.dart';

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
        return Scaffold(
          body: WillPopScope(
            onWillPop: willPopScope,
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<QuerySnapshot>(
                      // CRUD의 Read
                      future: lottoservice.read(user.uid),
                      builder: (context, snapshot) {
                        // 값이 있으면 docs 리스트, 없으면 [] (NULL 리스트) 형태로 값을 반환.
                        final documents = snapshot.data?.docs ?? [];

                        // 버킷 리스트가 비었을 경우
                        if (documents.isEmpty) {
                          return const Center(
                            child: Text("로또 번호를 등록해 주세요!"),
                          );
                        }
                        return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final docs = documents[index];
                            List<dynamic> lottoGames = docs.get("lottogames");
                            String json = _setLottoNum(lottoGames);

                            return ListTile(
                              title: LottoBallWidget(data: jsonDecode(json)),
                              // 삭제 아이콘 버튼
                              trailing: IconButton(
                                icon: const Icon(CupertinoIcons.delete),
                                onPressed: () {
                                  // 삭제 버튼 클릭시
                                  // CRUD에서 Delete
                                  lottoservice.delete(docs.id);
                                },
                              ),
                              onTap: () {
                                print("리스트 클릭!");
                              },
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      }),
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
