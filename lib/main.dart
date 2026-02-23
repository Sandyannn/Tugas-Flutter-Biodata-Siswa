import 'package:biodata/views/home.dart';
import 'package:flutter/material.dart';

 void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Biodata Siswa",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}