import 'package:flutter/material.dart';
import 'package:shop_easy/features/auth/screens/login_screen.dart';
import 'package:shop_easy/features/auth/screens/register_screen.dart';
import 'package:shop_easy/features/cart/screens/cart_screen.dart';
import 'package:shop_easy/features/product/screens/product_detail_screen.dart';
import 'package:shop_easy/features/product/widgets/product_cart.dart';

import '../../../core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  final bool isLoggedIn;

  const HomeScreen({super.key, this.isLoggedIn = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'Tất cả';

  final List<String> _categories = ['Tất cả', 'Điện thoại', 'Laptop', 'Thời trang', 'Phụ kiện', 'Giày dép'];

  final List _allProducts = [
    {
      'name': 'Giày Sneaker Thể Thao Nam Nữ Phong Cách',
      'category': 'Giày dép',
      'rating': 4.8,
      'reviewCount': 128,
      'currentPrice': 450000,
      'originalPrice': 600000,
      'discountPercent': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=900&q=80',
      'images': [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=900&q=80',
        'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?auto=format&fit=crop&w=900&q=80',
        'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&w=900&q=80',
      ],
    },
    {
      'name': 'Điện thoại thông minh cấu hình khủng RAM 12GB',
      'category': 'Điện thoại',
      'rating': 4.9,
      'reviewCount': 256,
      'currentPrice': 8900000,
      'originalPrice': 10500000,
      'discountPercent': 15,
      'imageUrl': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=900&q=80',
      'images': [
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=900&q=80',
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=900&q=80',
        'https://images.unsplash.com/photo-1569183091674-21a6d3f7c776?auto=format&fit=crop&w=900&q=80',
      ],
    },
    {
      'name': 'Laptop Gaming Hiệu Năng Cao Core i7',
      'category': 'Laptop',
      'rating': 4.7,
      'reviewCount': 89,
      'currentPrice': 21990000,
      'originalPrice': 25000000,
      'discountPercent': 12,
      'imageUrl': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=900&q=80',
      'images': [
        'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=900&q=80',
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=900&q=80',
        'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=900&q=80',
      ],
    },
    {
      'name': 'Áo khoác gió thể thao trượt nước cao cấp',
      'category': 'Thời trang',
      'rating': 4.6,
      'reviewCount': 45,
      'currentPrice': 320000,
      'originalPrice': 450000,
      'discountPercent': 28,
      'imageUrl': 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=900&q=80',
      'images': [
        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=900&q=80',
        'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?auto=format&fit=crop&w=900&q=80',
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=900&q=80',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _allProducts.where((product) {
      final matchesCategory = _selectedCategory == 'Tất cả' || product['category'] == _selectedCategory;
      final matchesSearch = product['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isLoggedIn ? 'ShopEasy - Trang chủ' : 'ShopEasy - Trang chủ'),
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
                      icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                    ),
                    Positioned(
                      right: 8,
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
              ]
            : [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  label: const Text(
                    'Đăng nhập',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  icon: const Icon(Icons.login_rounded, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
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
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
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
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: AppColors.surfaceAlt,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none,
                      ),
                      onSelected: (_) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'Không tìm thấy sản phẩm phù hợp',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.73,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final item = filteredProducts[index];
                      return ProductCart(
                        imageUrl: item['imageUrl'],
                        name: item['name'],
                        rating: item['rating'],
                        reviewCount: (item['reviewCount'] as num).toDouble(),
                        currentPrice: item['currentPrice'],
                        originalPrice: item['originalPrice'],
                        discountPercent: item['discountPercent'],
                        addToCart: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Đã thêm ${item['name']} vào giỏ hàng'),
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
                              builder: (context) => ProductDetailScreen(product: item),
                            ),
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