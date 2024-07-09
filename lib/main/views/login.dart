import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tech_lock/main/views/main_home.dart';

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
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    // 로그인 정보 객체 생성
    Map<String, String> loginData = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    // 로그인 정보 객체를 JSON으로 변환
    String loginDataJson = jsonEncode(loginData);

    // API 엔드포인트 URL
    String apiUrl = 'http://172.23.240.1:8080/users/login'; // 서버 URL로 변경

    try {
      // HTTP POST 요청 보내기
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: loginDataJson,
      );

      if (response.statusCode == 200) {
        print('로그인 성공');
        // 메인 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      } else {
        print('로그인 실패: ${response.body}');
        // 실패 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인에 실패했습니다. 다시 시도해주세요.')),
        );
      }
    } catch (e) {
      print('HTTP 요청 실패: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('네트워크 오류가 발생했습니다. 나중에 다시 시도해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '로그인',
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
                  controller: emailController,
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
                  controller: passwordController,
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
                  onPressed: () => login(context),
                  child: const Text('로그인'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
