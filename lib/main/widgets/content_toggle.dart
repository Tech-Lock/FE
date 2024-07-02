import 'package:flutter/material.dart';

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
          child: ContentToggle(),
        ),
      ),
    );
  }
}

class ContentToggle extends StatefulWidget {
  const ContentToggle({Key? key});

  @override
  _ContentToggleState createState() => _ContentToggleState();
}

class _ContentToggleState extends State<ContentToggle> {
  bool isPostSelected = true;

  void toggleSelection() {
    setState(() {
      isPostSelected = !isPostSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: toggleSelection,
          child: Container(
            width: 340,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: const Color(0xFFE8E8E8),
                width: 1.0,
              ),
            ),
          ),
        ),
        Positioned(
          left: 2,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isPostSelected = true;
              });
            },
            child: Container(
              width: 168,
              height: 46,
              decoration: BoxDecoration(
                color: isPostSelected ? const Color(0xFFFFFFFF) : const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  'Post',
                  style: TextStyle(
                    color: isPostSelected ? const Color(0xFF5DB075) : const Color(0xFFBDBDBD),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 2,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isPostSelected = false;
              });
            },
            child: Container(
              width: 168,
              height: 46,
              decoration: BoxDecoration(
                color: isPostSelected ? const Color(0xFFF6F6F6) : const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  'Photo',
                  style: TextStyle(
                    color: isPostSelected ? const Color(0xFFBDBDBD) : const Color(0xFF5DB075),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
