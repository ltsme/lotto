import 'package:flutter/material.dart';

class LottoSignUpPage extends StatefulWidget {
  const LottoSignUpPage({super.key});

  @override
  State<LottoSignUpPage> createState() => _LottoSignUpPageState();
}

class _LottoSignUpPageState extends State<LottoSignUpPage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Hello Flutter',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true, // 안드로이드에서 센터
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Image.network(
                    "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                    width: 81,
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(labelText: '이메일'),
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: '비밀번호'),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('로그인'),
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: textController,
                    maxLength:
                        10, // 최대 텍스트 필드 크기, 이것을 지정함으로써 counter가 자동 생성 (counterStyle:)
                    obscureText: true,
                    enabled: true,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                      ),
                      prefixIcon: Icon(Icons.perm_identity),
                      labelText: 'password',
                      helperText: '비밀번호는 10자 이상',
                      counterStyle: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onChanged: (text) {},
                    onSubmitted: (text) {
                      setState(() {
                        print(text);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
