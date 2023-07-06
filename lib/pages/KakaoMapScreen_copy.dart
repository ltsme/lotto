import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Kakao Api JavaScript 키
var kakaoMapKey = '953fcd9b73a5574241b4e6185312b34d';

class KakaoMapScreenCopy extends StatefulWidget {
  String url = '';
  KakaoMapScreenCopy({super.key, required this.url});

  @override
  State<KakaoMapScreenCopy> createState() => _KakaoMapScreenCopyState();
}

class _KakaoMapScreenCopyState extends State<KakaoMapScreenCopy> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.grey,
          child: KakaoMapView(
            width: 300,
            height: 400,
            kakaoMapKey: kakaoMapKey,
            lat: 40,
            lng: 127,
            showMapTypeControl: true,
            showZoomControl: true,
            draggableMarker: true,
            markerImageURL:
                'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
            onTapMarker: (message) {
              //event callback when the marker is tapped
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Marker is Clicked"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
