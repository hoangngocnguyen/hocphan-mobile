import 'package:dio/dio.dart';

Future<void> layMotSanPham() async {
  final dio = Dio();
  final response = await dio.get('https://dummyjson.com/products/1');
  
  print(response.statusCode); // 200
  print(response.data['title']); // Essence Mascara Lash Princess
  print(response.data['price']); // 9.99
}