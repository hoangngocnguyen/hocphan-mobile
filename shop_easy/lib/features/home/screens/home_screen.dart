import 'package:flutter/material.dart';
import 'package:shop_easy/features/auth/screens/login_screen.dart';
import 'package:shop_easy/features/auth/screens/register_screen.dart';
import 'package:shop_easy/features/cart/screens/cart_screen.dart';
import 'package:shop_easy/features/chat/screens/chat_screen.dart';
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

  final List<String> _categories = [
    'Tất cả',
    'Điện thoại',
    'Laptop',
    'Thời trang',
    'Phụ kiện',
    'Giày dép',
  ];

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
      'name': 'Laptop Lenovo ThinkBook 14 G6 IRL 21KG00BXVN (i5-13500H, Iris Xe Graphics, Ram 16GB DDR5, SSD 512GB, 14 Inch IPS WUXGA 60Hz, Win 11)',
      'category': 'Laptop',
      'rating': 4.7,
      'reviewCount': 89,
      'currentPrice': 21990000,
      'originalPrice': 25000000,
      'discountPercent': 12,
      'imageUrl': 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-5.jpg?v=1730690560750',
      'images': [
        'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-5.jpg?v=1730690560750',
        'https://bizweb.dktcdn.net/thumb/1024x1024/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-6.jpg?v=1730690560890',
        'https://bizweb.dktcdn.net/thumb/1024x1024/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-6.jpg?v=1730690560890',
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
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSXioZHMB2KS5qQSorYjEG6AoyXaqeaAMSHRMt4DaYtQ&s=10',
      'images': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSXioZHMB2KS5qQSorYjEG6AoyXaqeaAMSHRMt4DaYtQ&s=10',
        'https://aokhoacnam.vn/upload/product/akn-209/ao-gio-trang-chong-nuoc-cao-cap-0.jpg',
        'https://aokhoacnam.vn/upload/product/akn-209/ao-gio-trang-chong-nuoc-cao-cap-4.jpg',
      ],
    },
    {
      'name': 'Laptop Asus Vivobook 16 X1605VA-MB360W (i5-1335U, Iris Xe Graphics, Ram 16GB, SSD 512GB, 16 Inch IPS WUXGA 60Hz, Win 11)',
      'category': 'Laptop',
      'rating': 4.8,
      'reviewCount': 142,
      'currentPrice': 18490000,
      'originalPrice': 20990000,
      'discountPercent': 12,
      'imageUrl': 'https://cdn.tgdd.vn/Products/Images/44/309375/asus-vivobook-16-x1605va-i5-mb360w-glr-14-750x500.jpg',
      'images': [
        'https://cdn.tgdd.vn/Products/Images/44/309375/asus-vivobook-16-x1605va-i5-mb360w-glr-14-750x500.jpg',
        'https://cdn.tgdd.vn/Products/Images/44/309375/asus-vivobook-16-x1605va-i5-mb360w-glr-15-750x500.jpg',
      ],
    },
    {
      'name': 'Laptop Lenovo IdeaPad Slim 3 15IAH8 83ER00EVN (i5-12450H, UHD Graphics, Ram 16GB LPDDR5, SSD 512GB, 15.6 Inch IPS FHD, Win 11)',
      'category': 'Laptop',
      'rating': 4.6,
      'reviewCount': 215,
      'currentPrice': 14990000,
      'originalPrice': 17490000,
      'discountPercent': 14,
      'imageUrl': 'https://cdn.tgdd.vn/Products/Images/44/313333/Slider/vi-vn-lenovo-ideapad-slim-3-15iah8-i5-83er00evn-slider-3.jpg',
      'images': [
        'https://cdn.tgdd.vn/Products/Images/44/313333/Slider/vi-vn-lenovo-ideapad-slim-3-15iah8-i5-83er00evn-slider-3.jpg',
      ],
    },
    {
      'name': 'Laptop HP 15 fd0235TU 9Q970PA (i5-1334U, Iris Xe Graphics, Ram 16GB DDR4, SSD 512GB, 15.6 Inch IPS FHD 60Hz, Win 11)',
      'category': 'Laptop',
      'rating': 4.7,
      'reviewCount': 96,
      'currentPrice': 16590000,
      'originalPrice': 18990000,
      'discountPercent': 13,
      'imageUrl': 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/44/340486/hp-15-fd0235tu-i5-9q970pa-glr-14-638954299541143318.jpg',
      'images': [
        'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/44/340486/hp-15-fd0235tu-i5-9q970pa-glr-14-638954299541143318.jpg',
      ],
    },
    {
      'name': 'Laptop Lenovo ThinkBook 14 G6 IRL 21KG00BQVN (i7-1355U, Iris Xe Graphics, Ram 16GB DDR5, SSD 512GB, 14 Inch IPS WUXGA 100% sRGB, Win 11)',
      'category': 'Laptop',
      'rating': 4.9,
      'reviewCount': 117,
      'currentPrice': 20490000,
      'originalPrice': 22990000,
      'discountPercent': 11,
      'imageUrl': 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-5.jpg?v=1730690560750',
      'images': [
        'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-5.jpg?v=1730690560750',
        'https://bizweb.dktcdn.net/thumb/1024x1024/100/329/122/products/laptop-lenovo-thinkbook-14-g6-irl-21kg00bxvn-6.jpg?v=1730690560890',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _allProducts.where((product) {
      final matchesCategory =
          _selectedCategory == 'Tất cả' ||
          product['category'] == _selectedCategory;
      final matchesSearch = product['name'].toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();

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
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                              content: Text(
                                'Đã thêm ${item['name']} vào giỏ hàng',
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
                                  ProductDetailScreen(product: item),
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
