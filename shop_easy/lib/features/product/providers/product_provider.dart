import 'package:flutter/foundation.dart';
import 'package:shop_easy/features/product/models/product_model.dart';
import 'package:shop_easy/features/product/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service;

  List<Product> _products = [];
  Product? _selectedProduct;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _error;
  int _skip = 0;
  final int _limit = 10;

  // Getters
  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;
  String? get error => _error;

  ProductProvider({ProductService? service})
      : _service = service ?? ProductService();

  /// Load trang đầu tiên
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _skip = 0;
      final result = await _service.getProducts(limit: _limit, skip: _skip);
      _products = result.products;
      _skip = _products.length;
      _hasMore = _products.length < result.total;
    } catch (e) {
      _error = 'Không thể tải danh sách sản phẩm: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load thêm sản phẩm (infinite scroll / phân trang)
  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      final result = await _service.getProducts(limit: _limit, skip: _skip);
      _products.addAll(result.products);
      _skip = _products.length;
      _hasMore = _products.length < result.total;
    } catch (e) {
      _error = 'Không thể tải thêm sản phẩm: $e';
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  /// Load chi tiết 1 sản phẩm theo ID
  Future<void> fetchProductDetail(int id) async {
    _isLoading = true;
    _error = null;
    _selectedProduct = null;
    notifyListeners();

    try {
      _selectedProduct = await _service.getProductById(id);
    } catch (e) {
      _error = 'Không thể tải chi tiết sản phẩm: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh danh sách (pull-to-refresh)
  Future<void> refresh() async {
    _hasMore = true;
    await fetchProducts();
  }
}
