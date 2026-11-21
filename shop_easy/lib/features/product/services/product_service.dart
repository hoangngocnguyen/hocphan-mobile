import 'package:dio/dio.dart';
import 'package:shop_easy/features/product/models/product_model.dart';

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com';

  final Dio _dio;

  ProductService({Dio? dio}) : _dio = dio ?? Dio();

  /// Lấy danh sách sản phẩm có phân trang
  /// GET https://dummyjson.com/products?limit=10&skip=0
  /// Trả về danh sách [Product] và tổng số sản phẩm [total]
  Future<({List<Product> products, int total})> getProducts({
    int limit = 10,
    int skip = 0,
  }) async {
    final response = await _dio.get(
      '$_baseUrl/products',
      queryParameters: {
        'limit': limit,
        'skip': skip,
      },
    );

    final data = response.data;
    final List<dynamic> rawProducts = data['products'] as List<dynamic>;
    final products = rawProducts
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
    final total = data['total'] as int;

    return (products: products, total: total);
  }

  /// Lấy chi tiết 1 sản phẩm theo ID
  /// GET https://dummyjson.com/products/{id}
  Future<Product> getProductById(int id) async {
    final response = await _dio.get('$_baseUrl/products/$id');
    return Product.fromJson(response.data as Map<String, dynamic>);
  }
}
