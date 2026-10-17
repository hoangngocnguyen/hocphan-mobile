import 'package:app_nhom4/dia_diem.dart';
import 'package:app_nhom4/my_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // vẽ đối tượng MyApp lên màn hình
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt chữ Debug cho đẹp
      // node gốc, phát triển ra nhiều cây, nhiều thành phần giao diện.
      // home: MyHomePage(),
      home: DiaDiemPage(),
    );
  }
}
