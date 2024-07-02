import 'package:flutter/material.dart';
import 'package:tech_lock/main/widgets/lock_toggle.dart';
import 'package:tech_lock/main/widgets/content_toggle.dart';

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
                ContentToggle(),
              ],
            ),
          ),
          Positioned(
            top: 440,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 340,
                      height: 340,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E8E8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
