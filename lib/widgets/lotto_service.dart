import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LottoService extends ChangeNotifier {
  final lottoCollection = FirebaseFirestore.instance.collection('lotto');

  Future<QuerySnapshot> read(String uid) async {
    // LottoGame Read
    return lottoCollection.where('uid', isEqualTo: uid).get();
  }

  void create(String uid, List<int> lottoGames, String date) async {
    // LottoGame Create
    await lottoCollection.add({
      'uid': uid,
      'lottogames': lottoGames,
      'date': date,
    });
  }

  void delete(String docId) async {
    // LottoGame Delete
    await lottoCollection.doc(docId).delete();
    notifyListeners();
  }
}
