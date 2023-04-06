import 'package:flutter/material.dart';

class QrScanResultPage extends StatelessWidget {
  final data;
  const QrScanResultPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(data),
    );
  }
}
