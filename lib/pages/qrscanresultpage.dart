import 'package:flutter/material.dart';
import 'package:lotto/pages/login/lotto_onboardingpage.dart';
import 'package:lotto/widgets/appbar.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'lotto_mainpage_home.dart';

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
        appBar: AppBarWidget(context),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted, // 웹에서 javascript 자유롭게 실행
        ));
  }
}
