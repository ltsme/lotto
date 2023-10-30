import 'package:flutter/material.dart';
import 'package:lotto/pages/login/lotto_loginpage.dart';
import 'package:lotto/widgets/auth_service.dart';
import 'package:lotto/widgets/sharedata.dart';
import 'package:provider/provider.dart';

AppBar AppBarWidget(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.black),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            // 공통 스타일
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            children: [
              TextSpan(
                text: "L",
                style: TextStyle(
                  color: lottoColorBlue,
                ),
              ),
              TextSpan(
                text: "o",
                style: TextStyle(
                  color: appMainColor,
                ),
              ),
              TextSpan(
                text: "tt",
                style: TextStyle(
                  color: lottoColorBlue,
                ),
              ),
              const TextSpan(
                text: "o",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              const TextSpan(
                text: " ",
                style: TextStyle(fontSize: 5),
              ),
              TextSpan(
                text: "6",
                style: TextStyle(color: lottoColorBlue, fontSize: 19),
              ),
              const TextSpan(
                text: "/",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 21,
                ),
              ),
              TextSpan(
                text: "45",
                style: TextStyle(color: lottoColorBlue, fontSize: 19),
              ),
            ],
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: const Text(
                    '로그아웃 하나요?',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text("취소"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: const Text("로그아웃"),
                            onPressed: () {
                              AuthService authService =
                                  context.read<AuthService>();
                              authService.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LottoLoginPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                );
              });
        },
        icon: const Icon(
          Icons.logout_outlined,
        ),
      ),
    ],
  );
}
