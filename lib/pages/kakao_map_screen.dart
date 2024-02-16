import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:lotto/pages/lotto_mainpage_home.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Kakao Api JavaScript 키
var kakaoMapKey = '953fcd9b73a5574241b4e6185312b34d';

bool mapPermission = false;

class KakaoMapScreen extends StatefulWidget {
  final double posLat, posLon;

  const KakaoMapScreen({super.key, required this.posLat, required this.posLon});

  @override
  State<KakaoMapScreen> createState() => _KakaoMapScreenState();
}

class _KakaoMapScreenState extends State<KakaoMapScreen> {
  late WebViewController _mapController;

  @override
  void initState() {
    log("Lat = $posLat Lon $posLon");
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: WebView(
  //       zoomEnabled: true,
  //       initialUrl:
  //           "https://m.map.kakao.com/actions/searchView?q=로또 판매점&wxEnc=LVSMQP&wyEnc=QNMLQRS&lvl=8#!/all/map/place",
  //       javascriptMode: JavascriptMode.unrestricted, // 웹에서 javascript 자유롭게 실행
  //     ),
  //   );
  // }

  // 카카오 맵 띄우기
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.grey,
        child: KakaoMapView(
          mapController: (controller) {
            _mapController = controller;
          },
          width: 300,
          height: 400,
          kakaoMapKey: kakaoMapKey,
          lat: posLat,
          lng: posLon,
          showMapTypeControl: true,
          showZoomControl: true,
          draggableMarker: true,
          markerImageURL: 'https://i.ibb.co/qF0Q6Xj/icon-mapping.png',
          onTapMarker: (message) {
            //event callback when the marker is tapped
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Marker is Clicked"),
              ),
            );
          },
        ),
      ),
    );
  }
}
