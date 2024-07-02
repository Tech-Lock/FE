import 'package:flutter/material.dart';
import 'package:tech_lock/main/views/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF000000),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF5DB075),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFFFFF), // ElevatedButton 색상 설정
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true, // 배경을 채울지 여부
          fillColor: Color(0xFFF6F6F6), // 배경색 설정
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE8E8E8)), // 비활성화 상태의 테두리 색상 설정
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF5DB075)), // 포커스 상태의 테두리 색상 설정
          ),
        ),
      ),
      home: const SignUpPage(),
    );
  }
}


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontSize: 30, // 원하는 글자 크기로 설정
            fontWeight: FontWeight.w900, // 글씨 두껍게 설정
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white, // 흰색 배경
          ),
          Positioned(
            top: 30.0,
            left: 20.0,
            right: 20.0,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '이름',
                    labelStyle: TextStyle(color: Color(0xFFBDBDBD)),
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '이메일',
                    labelStyle: TextStyle(color: Color(0xFFBDBDBD)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '비밀번호',
                    labelStyle: TextStyle(color: Color(0xFFBDBDBD)),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text('회원가입'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
