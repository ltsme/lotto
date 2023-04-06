import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LottoService extends ChangeNotifier {
  final lottoCollection = FirebaseFirestore.instance.collection('lotto');

  Future<QuerySnapshot> read(String uid) async {
    // LottoGame Read
    return lottoCollection.where('uid', isEqualTo: uid).get();
  }

  void create(String uid, List<int> lottoGames) async {
    // LottoGame Create
    await lottoCollection.add({
      'uid': uid,
      'lottogames': lottoGames,
    });
  }

  void delete(String docId) {
    // LottoGame Delete
  }
}
