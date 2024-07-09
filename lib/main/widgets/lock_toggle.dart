import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const LockToggle({Key? key}) : super(key: key);

  @override
  _LockToggleState createState() => _LockToggleState();
}

class _LockToggleState extends State<LockToggle> {
  bool isLockSelected = true;

  void toggleSelection() async {
    setState(() {
      isLockSelected = !isLockSelected;
    });

    final String apiUrl = isLockSelected
        ? 'http://172.23.240.1:8080/main/door/close'
        : 'http://172.23.240.1:8080/main/door/open';

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('Request to $apiUrl successful');
      } else {
        print('Request to $apiUrl failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Request to $apiUrl failed with error: $e');
    }
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
