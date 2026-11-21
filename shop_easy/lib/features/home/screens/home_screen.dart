import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy/features/auth/screens/login_screen.dart';
import 'package:shop_easy/features/auth/screens/register_screen.dart';
import 'package:shop_easy/features/cart/screens/cart_screen.dart';
import 'package:shop_easy/features/chat/screens/chat_screen.dart';
import 'package:shop_easy/features/product/models/product_model.dart';
import 'package:shop_easy/features/product/providers/product_provider.dart';
import 'package:shop_easy/features/product/screens/product_detail_screen.dart';
import 'package:shop_easy/features/product/widgets/product_cart.dart';
import 'package:shop_easy/features/weather/screens/weather_screen.dart';

import '../../../core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  final bool isLoggedIn;

  const HomeScreen({super.key, this.isLoggedIn = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Lần đầu load danh sách sản phẩm từ API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });

    // Lắng nghe scroll để load more (infinite scroll)
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductProvider>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final allProducts = productProvider.products;

    // Lọc theo search query
    final filteredProducts = _searchQuery.isEmpty
        ? allProducts
        : allProducts
            .where((product) =>
                product.title.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isLoggedIn ? 'ShopEasy - Trang chủ' : 'ShopEasy - Trang chủ',
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: widget.isLoggedIn
            ? [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 28.0,
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 8,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),

                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeatherScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.wb_sunny_outlined,
                    color: Colors.white,
                    size: 26.0,
                  ),
                ),
                const SizedBox(width: 8),

                // 2. Nút nhắn tin
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: Colors.white,
                    size: 26.0,
                  ),
                ),
              ]
            : [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  label: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: const Icon(Icons.login_rounded, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8.0,
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thanh tìm kiếm
          Container(
            padding: const EdgeInsets.all(16.0),
            color: AppColors.surface,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm sản phẩm...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                filled: true,
                fillColor: AppColors.surfaceAlt,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Nội dung chính
          Expanded(
            child: _buildBody(productProvider, filteredProducts),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ProductProvider provider, List<Product> products) {
    // Trạng thái loading lần đầu
    if (provider.isLoading && provider.products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Trạng thái lỗi
    if (provider.error != null && provider.products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.textSecondary),
            const SizedBox(height: 12),
            Text(
              provider.error!,
              style: const TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => provider.refresh(),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    // Danh sách rỗng
    if (products.isEmpty) {
      return const Center(
        child: Text(
          'Không tìm thấy sản phẩm phù hợp',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    // Danh sách sản phẩm + load more
    return RefreshIndicator(
      onRefresh: () => provider.refresh(),
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.73,
        ),
        // +1 nếu đang load more để hiện indicator ở cuối
        itemCount: products.length + (provider.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          // Indicator load more ở cuối danh sách
          if (index >= products.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final product = products[index];
          return ProductCart(
            product: product,
            addToCart: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Đã thêm ${product.title} vào giỏ hàng',
                  ),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            onFavoritePressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã lưu sản phẩm yêu thích'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
