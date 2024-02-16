import 'package:flutter/material.dart';
import 'package:lotto/widgets/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QrScanResultPage extends StatefulWidget {
  String? url;

  QrScanResultPage({super.key, required this.url});

  @override
  State<QrScanResultPage> createState() => _QrScanResultPageState();
}

class _QrScanResultPageState extends State<QrScanResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted, // 웹에서 javascript 자유롭게 실행
        ));
  }
}
