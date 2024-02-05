// import 'package:booktree/addBook.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert'; // for json

// class SearchBook extends StatefulWidget {
//   final String rbooktitle;

//   const SearchBook({Key? key, required this.rbooktitle}) : super(key: key);

//   @override
//   _SearchBookState createState() => _SearchBookState(rbooktitle);
// }

// class _SearchBookState extends State<SearchBook> {
//   String result = '';
//   String search = '';
//   late List data;

//   TextEditingController textController = TextEditingController();
//   late ScrollController _scrollController;
//   int page = 1;

//   //Create Constructor
//   _SearchBookState(String rbookTitle) {
//     this.booktitle = rbookTitle;
//   }

//   late String booktitle;

//   @override
//   void initState() {
//     super.initState();
//     data = [];
//     _scrollController = ScrollController();

//     getJSONData();

//     _scrollController.addListener(() {
//       //리스트의 마지막일 경우
//       if (_scrollController.offset >=
//               _scrollController.position.maxScrollExtent &&
//           !_scrollController.position.outOfRange) {
//         page += 1;
//         getJSONData();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: textController,
//           keyboardType: TextInputType.text,
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   data.clear();
//                   page = 1;
//                   getJSONData();
//                 });
//               },
//               icon: Icon(Icons.search))
//         ],
//       ),
//       body: Container(
//         child: data.length == 0
//             ? Text(
//                 "",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               )
//             : ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         setState(() {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) {
//                             return AddBook(
//                                 rBookImage: data[index]['thumbnail'].toString(),
//                                 rBookTitle: data[index]['title'].toString(),
//                                 rBookPublisher:
//                                     data[index]['publisher'].toString(),
//                                 rBookAuthors: data[index]['authors']
//                                     .toString()
//                                     .substring(
//                                         1,
//                                         data[index]['authors']
//                                                 .toString()
//                                                 .length -
//                                             1));
//                           }));
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(5),
//                                 child: ExtendedImage.network(
//                                   data[index]['thumbnail'],
//                                   height: 150, width: 120, fit: BoxFit.contain,

//                                   // 로딩 중, 로딩 실패 케이스 구분
//                                   loadStateChanged: (ExtendedImageState state) {
//                                     switch (state.extendedImageLoadState) {
//                                       // 로딩 중 스피너 이미지
//                                       case LoadState.loading:
//                                         return Image.asset(
//                                           "images/Spinner_200px.gif",
//                                           width: 120,
//                                           height: 150,
//                                           fit: BoxFit.fill,
//                                         );
//                                       // 로딩 실패 시 기본 이미지
//                                       case LoadState.failed:
//                                         return GestureDetector(
//                                           child: Image.asset(
//                                             "images/splash.png",
//                                             width: 120,
//                                             height: 150,
//                                             fit: BoxFit.fill,
//                                           ),
//                                           // 클릭 시, 이미지 재 로드
//                                           onTap: () {
//                                             state.reLoadImage();
//                                           },
//                                         );
//                                       default:
//                                     }
//                                   },
//                                 ),
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     width: 200.0,
//                                     child: Text(
//                                       data[index]['title'].toString(),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       softWrap: false,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10.0,
//                                   ),
//                                   Text(
//                                     data[index]['publisher'].toString(),
//                                     style: TextStyle(fontSize: 15),
//                                   ),
//                                   SizedBox(
//                                     width: 200,
//                                     child: Text(
//                                       data[index]['authors'].toString(),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       softWrap: false,
//                                       style: TextStyle(fontSize: 15),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 40.0,
//                                   ),
//                                   Text(
//                                     data[index]['datetime'].length < 10
//                                         ? data[index]['datetime']
//                                         : data[index]['datetime']
//                                             .toString()
//                                             .substring(0, 4)
//                                             .replaceRange(4, 4, '년'),
//                                     style: TextStyle(fontSize: 15),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 itemCount: data.length,
//                 controller: _scrollController,
//               ),
//       ),
//     );
//   }

// Future<String> getJSONData() async {
//   search = textController.text != '' ? textController.text : booktitle;
//   var url = Uri.parse(
//       'https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=$search');

//   var response = await http.get(url,
//       headers: {"Authorization": "KakaoAK cc2b06bbe7a475f7910fd34d95c8ff82"});

//   setState(() {
//     var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
//     List result = dataConvertedJSON['documents'];
//     data.addAll(result);
//   });
//   return "Success";
// }

//   void _getRequest() async {
//     String str = Uri.encodeQueryComponent('$queryText');
//     String url = 'https://openapi.naver.com/v1/search/news.json';
//     String opt = '&display=50&sort=sim';

//     var regUrl = Uri.parse("$url?query=$str$opt");
//     print('날아간 regUrl = $regUrl');

//     http.Response response = await http.get(
//       regUrl,
//       headers: {
//         "X-Naver-Client-Id": "n2rE3LFU92tc11751Q3r",
//         "X-Naver-Client-Secret": "X2t8njWhHP"
//       },
//     );

//     var statusCode = response.statusCode;
//     var responseHeaders = response.headers;
//     var responseBody = utf8.decode(response.bodyBytes);

//     print('get_statusCode : $statusCode');
//     print('get_responseHeaders : $responseHeaders');
//     print('get_responseBody : $responseBody'); // 한글을 위해
//   }
// }
