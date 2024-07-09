import 'package:flutter/material.dart';
import 'package:tech_lock/main/views/login.dart';
import 'package:tech_lock/main/database/user_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    // UserData 객체 생성
    UserData userData = UserData(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    // UserData 객체를 JSON으로 변환
    String userDataJson = jsonEncode(userData.toJson());

    // API 엔드포인트 URL
    String apiUrl = 'https://localhost:8080/users/signup';

    try {
      // HTTP POST 요청 보내기
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'X-NCP-APIGW-API-KEY-ID': '20w7aovkjr', // 네이버 클라우드 API 키 ID
          'X-NCP-APIGW-API-KEY': 'Tg8rUUvLGbxrcrJTZIrXMUHW6NmpxsEMZiEUnacb', // 네이버 클라우드 API 키
        },
        body: userDataJson,
      );

      if (response.statusCode == 200) {
        print('회원가입 성공');
        // 로그인 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        print('회원가입 실패: ${response.body}');
        // 실패 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('회원가입에 실패했습니다. 다시 시도해주세요.')),
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
          '회원가입',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Positioned(
            top: 30.0,
            left: 20.0,
            right: 20.0,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
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
                  onPressed: () => signUp(context),
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
