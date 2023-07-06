import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Kakao Api JavaScript 키
var kakaoMapKey = '953fcd9b73a5574241b4e6185312b34d';

class KakaoMapScreen extends StatefulWidget {
  String url = '';
  KakaoMapScreen({super.key, required this.url});

  @override
  State<KakaoMapScreen> createState() => _KakaoMapScreenState();
}

class _KakaoMapScreenState extends State<KakaoMapScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // 화면 비율
    return Scaffold(
      appBar: AppBar(title: Text('Kakao map webview test')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          KakaoMapView(
              width: size.width,
              height: size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top,
              kakaoMapKey: kakaoMapKey,
              lat: 37.402056,
              lng: 127.108212,
              overlayText: "Dd",
              showMapTypeControl: true,
              showZoomControl: true,
              markerImageURL:
                  'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',

              // JavaScript랑 연결???..
              customScript: '''
              var markers = []; 
              function addMarker(position) {

      var marker = new kakao.maps.Marker({position: position});

      marker.setMap(map);

      markers.push(marker);
    }

    for(var i = 0 ; i < 3 ; i++){
      addMarker(new kakao.maps.LatLng(33.450701 + 0.0003 * i, 126.570667 + 0.0003 * i));

      kakao.maps.event.addListener(markers[i], 'click', function(){
        onTapMarker.postMessage('marker ' + i + ' is tapped');
     });
    }

		  var zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

      var mapTypeControl = new kakao.maps.MapTypeControl();
      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);,
      
              ''',
              onTapMarker: (message) async {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message.message)));
                await _openKakaoMapScreen(context);
              }),
        ],
      ),
    );
  }

  Future<void> _openKakaoMapScreen(BuildContext context) async {
    KakaoMapUtil util = KakaoMapUtil();

    // String url = await util.getResolvedLink(
    //     util.getKakaoMapURL(37.402056, 127.108212, name: 'Kakao 본사'));

    /// This is short form of the above comment
    String url =
        await util.getMapScreenURL(33.450701, 126.570667, name: 'Kakao 본사');

    Navigator.push(
        context, MaterialPageRoute(builder: (_) => KakaoMapScreen(url: url)));
  }
}