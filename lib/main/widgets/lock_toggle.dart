import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          child: LockToggle(),
        ),
      ),
    );
  }
}

class LockToggle extends StatefulWidget {
  const LockToggle({Key? key});

  @override
  _LockToggleState createState() => _LockToggleState();
}

class _LockToggleState extends State<LockToggle> {
  bool isLockSelected = true;

  void toggleSelection() {
    setState(() {
      isLockSelected = !isLockSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSelection,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD9D9D9),
                  border: Border.all(
                    color: Colors.white,
                    width: 4.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                isLockSelected ? 'assets/icons/lock_on.svg' : 'assets/icons/lock_off.svg',
                width: 80,
                height: 80,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            isLockSelected ? 'Locked' : 'Unlocked',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
