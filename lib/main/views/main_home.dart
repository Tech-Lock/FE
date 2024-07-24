import 'package:flutter/material.dart';
import 'package:tech_lock/main/widgets/lock_toggle.dart';
import 'package:tech_lock/main/widgets/random_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white, // 흰색 배경
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250.0,
            child: Container(
              color: const Color(0xFF5DB075),
            ),
          ),
          const Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: LockToggle(), // LockToggle 추가
          ),
          const Positioned(
            top: 370,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RandomPassword(),
              ],
            ),
          ),
          Positioned(
            top: 440,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
              itemCount: 20, // 예시로 20개의 아이템을 생성
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Expanded(
                            child: Text(
                              '2024/06/25 18:34\n등록된 사용자입니다.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: const Color(0xFFE8E8E8),
                      margin: const EdgeInsets.only(left: 90, right: 20),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}