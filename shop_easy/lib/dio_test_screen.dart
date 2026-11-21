import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioTestScreen extends StatefulWidget {
  const DioTestScreen({super.key});

  @override
  State<DioTestScreen> createState() => _DioTestScreenState();
}

class _DioTestScreenState extends State<DioTestScreen> {
  final _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
  String _result = 'Chưa gọi';

  Future<void> _fetchProduct() async {
    setState(() => _result = 'Đang tải...');
    try {
      final response = await _dio.get('/products/1');
      final title = response.data['title'];
      final price = response.data['price'];
      debugPrint('$title - $price USD');
      setState(() => _result = '$title - $price USD');
    } on DioException catch (e) {
      debugPrint('Lỗi: ${e.message}');
      setState(() => _result = 'Lỗi: ${e.message}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test 1 nút gọi API')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: _fetchProduct,
              child: const Text('Lấy sản phẩm'),
            ),
            const SizedBox(height: 12),
            Text(_result),
          ],
        ),
      ),
    );
  }
}