import 'package:flutter/material.dart';

class LottoBallWidget extends StatelessWidget {
  final data;
  const LottoBallWidget({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.9,
      // height: MediaQuery.of(context).size.height * 0.1,
      color: Colors.amber, // test용
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Material(
              color: data['drwtNo1'] < 11
                  ? Colors.yellow
                  : data['drwtNo1'] < 21
                      ? Colors.blue
                      : data['drwtNo1'] < 31
                          ? Colors.red
                          : data['drwtNo1'] < 41
                              ? Colors.grey
                              : Colors.green, // button color
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: Text(
                    data['drwtNo1'] < 10
                        ? '0${data['drwtNo1'].toString()}'
                        : '${data['drwtNo1'].toString()}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ClipOval(
            child: Material(
              color: data['drwtNo2'] < 11
                  ? Colors.yellow
                  : data['drwtNo2'] < 21
                      ? Colors.blue
                      : data['drwtNo2'] < 31
                          ? Colors.red
                          : data['drwtNo2'] < 41
                              ? Colors.grey
                              : Colors.green, // button color
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: Text(
                    data['drwtNo2'] < 10
                        ? '0${data['drwtNo2'].toString()}'
                        : '${data['drwtNo2'].toString()}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ClipOval(
            child: Material(
              color: data['drwtNo3'] < 11
                  ? Colors.yellow
                  : data['drwtNo3'] < 21
                      ? Colors.blue
                      : data['drwtNo3'] < 31
                          ? Colors.red
                          : data['drwtNo3'] < 41
                              ? Colors.grey
                              : Colors.green, // button color
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: Text(
                    data['drwtNo3'] < 10
                        ? '0${data['drwtNo3'].toString()}'
                        : '${data['drwtNo3'].toString()}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ClipOval(
            child: Material(
              color: data['drwtNo4'] < 11
                  ? Colors.yellow
                  : data['drwtNo4'] < 21
                      ? Colors.blue
                      : data['drwtNo4'] < 31
                          ? Colors.red
                          : data['drwtNo4'] < 41
                              ? Colors.grey
                              : Colors.green, // button color
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: Text(
                    data['drwtNo4'] < 10
                        ? '0${data['drwtNo4'].toString()}'
                        : '${data['drwtNo4'].toString()}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ClipOval(
            child: Material(
              color: data['drwtNo5'] < 11
                  ? Colors.yellow
                  : data['drwtNo5'] < 21
                      ? Colors.blue
                      : data['drwtNo5'] < 31
                          ? Colors.red
                          : data['drwtNo5'] < 41
                              ? Colors.grey
                              : Colors.green, // button color
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: Text(
                    data['drwtNo5'] < 10
                        ? '0${data['drwtNo5'].toString()}'
                        : '${data['drwtNo5'].toString()}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ClipOval(
            child: Material(
              color: data['drwtNo6'] < 11
                  ? Colors.yellow
                  : data['drwtNo6'] < 21
                      ? Colors.blue
                      : data['drwtNo6'] < 31
                          ? Colors.red
                          : data['drwtNo6'] < 41
                              ? Colors.grey
                              : Colors.green, // button color
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: Text(
                    data['drwtNo6'] < 10
                        ? '0${data['drwtNo6'].toString()}'
                        : '${data['drwtNo6'].toString()}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          data['bnusNo'] == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
          data['bnusNo'] == null
              ? Container()
              : ClipOval(
                  child: Material(
                    color: data['bnusNo'] < 11
                        ? Colors.yellow
                        : data['bnusNo'] < 21
                            ? Colors.blue
                            : data['bnusNo'] < 31
                                ? Colors.red
                                : data['bnusNo'] < 41
                                    ? Colors.grey
                                    : Colors.green, // button color
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        child: Text(
                          data['bnusNo'] < 10
                              ? '0${data['bnusNo'].toString()}'
                              : '${data['bnusNo'].toString()}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
