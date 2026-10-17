import 'package:flutter/material.dart';

// không cần giống tên file
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // cành có sẵn, ngoài ra còn có 4 cành khác
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Xin chào Hoàng',
            style: TextStyle(
              color: Colors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            'Chúc bạn một ngày tốt lành',
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          Image.network(getImageUrl()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.person, size: 30, color: Colors.amber),
              Icon(Icons.favorite, size: 30, color: Colors.pink),
              Icon(Icons.person_2_outlined, size: 30, color: Colors.blueAccent),
            ],
          ),
        ],
      ), // nút lá Text
    ); // cây này đã có sẵn (ta chỉ cần trang trí cái cây)
  }

  String getImageUrl() {
    return 'https://images.unsplash.com/photo-1542810104-c5f07c7357ff?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D';
  }
}
