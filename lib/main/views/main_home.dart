import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tech_lock/main/widgets/lock_toggle.dart';
import 'package:tech_lock/main/widgets/random_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<String>> _imageUrls;

  @override
  void initState() {
    super.initState();
    _imageUrls = _fetchImageUrls();
  }

  Future<List<String>> _fetchImageUrls() async {
    final storageRef = FirebaseStorage.instance.ref();
    final listResult = await storageRef.child('images').listAll();
    final urls = <String>[];

    for (var item in listResult.items) {
      final url = await item.getDownloadURL();
      urls.add(url);
    }

    return urls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200.0,
            child: Container(
              color: const Color(0xFF5DB075),
            ),
          ),
          const Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: LockToggle(),
          ),
          const Positioned(
            top: 320,
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
            top: 390,
            left: 0,
            right: 0,
            bottom: 0,
            child: FutureBuilder<List<String>>(
              future: _imageUrls,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No images found.'));
                }

                final imageUrls = snapshot.data!;

                return ListView.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    final imageUrl = imageUrls[index];
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
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  ),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
