import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: RandomPassword(),
        ),
      ),
    );
  }
}

class RandomPassword extends StatefulWidget {
  const RandomPassword({Key? key});

  @override
  _RandomPasswordState createState() => _RandomPasswordState();
}

class _RandomPasswordState extends State<RandomPassword> {
  bool isPostSelected = true;

  void toggleSelection() {
    setState(() {
      isPostSelected = !isPostSelected;
    });
    _showRandomNumberModal(context);
  }

  void _showRandomNumberModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final randomNumber = 1000 + Random().nextInt(9000); // 100000부터 999999까지의 랜덤 숫자
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child: Text(
              '$randomNumber',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSelection,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 340,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: const Color(0xFFE8E8E8),
            width: 1.0,
          ),
        ),
        child: const Center(
          child: Text(
            '일회용 비밀번호 생성',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
