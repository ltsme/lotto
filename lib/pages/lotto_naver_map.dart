import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:lotto/widgets/appbar.dart';
import 'package:geolocator/geolocator.dart';

// https://note11.dev/flutter_naver_map/ naver_map 공식 개발 문서

class LottoNaverMap extends StatefulWidget {
  const LottoNaverMap({super.key});

  @override
  State<LottoNaverMap> createState() => _LottoNaverMapState();
}

class _LottoNaverMapState extends State<LottoNaverMap> {
  late NaverMapController _naverMapController;
  late LocationData _currentLocation;
  final Location _location = Location();
  bool cLocation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("init");
    _initialAndSearch();
  }

  Future<void> _initialAndSearch() async {
    await _initializeLocation();
    _searchNearbyPlaces();
  }

  // // 현재 위 경도 구하는 메소드
  // Future<void> _getLocation() async {
  //   // Geolocator 패키지는 위치 정보를 가져오는 기능을 제공
  //   LocationPermission permission = await Geolocator.requestPermission();

  //   if (permission == LocationPermission.always) {
  //     log("permission = always");
  //     testPermissiion == 'Always';
  //     mapPermission = true;
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);

  //     setState(() {
  //       posLat = position.latitude;
  //       posLon = position.longitude;
  //       log("setState Test lat = $posLat, lon = $posLon");
  //     });
  //   } else if (permission == LocationPermission.whileInUse) {
  //     log("permission = whileInUse");
  //     testPermissiion == 'whileInUse';
  //     mapPermission = true;
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);

  //     setState(() {
  //       posLat = position.latitude;
  //       posLon = position.longitude;
  //       log("setState Test lat = $posLat, lon = $posLon");
  //     });
  //   } else {
  //     mapPermission = false;
  //     testPermissiion = 'denied';
  //   }
  // }

  Future _initializeLocation() async {
    log("initLoca");
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _currentLocation = await _location.getLocation();
    cLocation = true;
    setState(() {});
  }

  Future _searchNearbyPlaces() async {
    log("searchNear");
    log("https://naveropenapi.apigw.ntruss.com/map-place/v1/search?query=로또판매점&coordinate=${_currentLocation.longitude},${_currentLocation.latitude}&radius=1000");
    final clientId = 'rttrpib4ti';
    final apiKey = 'XQFVKgEhjKaekeATEMzZ3asWR3dbd1kVwrJ0juBt';
    final url =
        'https://naveropenapi.apigw.ntruss.com/map-place/v1/search?query=로또판매점&coordinate=${_currentLocation.longitude},${_currentLocation.latitude}&radius=1000';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-NCP-APIGW-API-KEY-ID': clientId,
        'X-NCP-APIGW-API-KEY': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log("Date is $data");
      final places = data['places'];

      _naverMapController.clearOverlays();
      for (var place in places) {
        final marker = NMarker(
          id: 'lotto_marker',
          position: NLatLng(place['y'], place['x']),
          caption: NOverlayCaption(
            text: place['name'],
            color: Colors.blue,
            textSize: 12,
          ),
          alpha: 0.8,
          isFlat: true,
        );
        _naverMapController.addOverlay(marker);
        log("내 위치는 ${_currentLocation.latitude}, 그리고 ${_currentLocation.altitude}");
      }
    } else {
      log("Fail");
      log(response.body);
      throw Exception('지도 정보를 찾는데 실패했습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: cLocation == false
          ? const Center(child: CircularProgressIndicator())
          : NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                  target: NLatLng(_currentLocation!.latitude!,
                      _currentLocation!.longitude!),
                  zoom: 15,
                  //bearing: 45,
                  //tilt: 30,
                ),
              ),
              onMapReady: (NaverMapController controller) {
                log("네이버 맵 로드 완료");
                //_naverMapController = controller;
              },
            ),
    );
  }
}
