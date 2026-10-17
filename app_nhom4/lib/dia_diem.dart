import 'package:flutter/material.dart';

class DiaDiemPage extends StatelessWidget {
  const DiaDiemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hình ảnh địa điểm
            Image.network(
              getImageUrl(),
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            // 2. Tên địa điểm và đánh giá sao
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                children: [
                  // Cột chứa tên và vị trí
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Ngắm Hoa Anh Đào Tokyo',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Tokyo, Nhật Bản',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  // Đánh giá sao
                  const Icon(Icons.star, color: Colors.amber, size: 24),
                  const SizedBox(width: 4),
                  const Text(
                    '5.0',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // 3. Hàng nút chức năng (Gọi điện, Chỉ đường, Chia sẻ)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Nút 1: Gọi điện
                  Column(
                    children: const [
                      Icon(Icons.phone, color: Colors.pinkAccent),
                      SizedBox(height: 6),
                      Text(
                        'Gọi điện',
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  // Nút 2: Chỉ đường
                  Column(
                    children: const [
                      Icon(Icons.near_me, color: Colors.pinkAccent),
                      SizedBox(height: 6),
                      Text(
                        'Chỉ đường',
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  // Nút 3: Chia sẻ
                  Column(
                    children: const [
                      Icon(Icons.share, color: Colors.pinkAccent),
                      SizedBox(height: 6),
                      Text(
                        'Chia sẻ',
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 4. Đoạn văn mô tả địa điểm
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Tokyo mùa hoa anh đào là một trong những điểm đến lãng mạn và tuyệt đẹp nhất tại Nhật Bản. '
                    'Du khách có thể dạo bước dưới những hàng cây hoa nở rộ sắc hồng quanh các công viên nổi tiếng như Ueno hay Shinjuku Gyoen, '
                    'thưởng thức văn hóa ngắm hoa Hanami cùng người thân và gia đình.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getImageUrl() {
    return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQ_jclGZaCL5vghCeYXYJuYGhf9c7UQJQ791CC4n8mPg&s=10';
  }
}
