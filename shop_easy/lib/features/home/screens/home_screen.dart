import 'package:flutter/material.dart';
import 'package:shop_easy/features/auth/screens/login_screen.dart';
import 'package:shop_easy/features/auth/screens/register_screen.dart';
import 'package:shop_easy/features/product/widgets/product_cart.dart';

import '../../../core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  // Trạng thái tìm kiếm và danh mục đang chọn
  String _searchQuery = '';
  String _selectedCategory = 'Tất cả';

  // Danh mục mẫu
  final List<String> _categories = ['Tất cả', 'Điện thoại', 'Laptop', 'Thời trang', 'Phụ kiện', 'Giày dép'];

  // Dữ liệu sản phẩm mẫu
  final List _allProducts = [
    {
      'name': 'Giày Sneaker Thể Thao Nam Nữ Phong Cách',
      'category': 'Giày dép',
      'rating': 4.8,
      'reviewCount': 128,
      'currentPrice': 450000,
      'originalPrice': 600000,
      'discountPercent': 25,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXkTNL_4eIZHiaUfHc-lMzYQ42Ess6OihOJFYvVQai8Q&s=10',
    },
    {
      'name': 'Điện thoại thông minh cấu hình khủng RAM 12GB',
      'category': 'Điện thoại',
      'rating': 4.9,
      'reviewCount': 256,
      'currentPrice': 8900000,
      'originalPrice': 10500000,
      'discountPercent': 15,
      'imageUrl': 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRKCNEYGyUn2QHRCgis0Hy4dp4WfNR8WNAzxh5eChl2QlWprINlngvFDFljJdGDrUOlCpVTfHcaxL4nREcCksv7gn2Fxqbb',
    },
    {
      'name': 'Laptop Gaming Hiệu Năng Cao Core i7',
      'category': 'Laptop',
      'rating': 4.7,
      'reviewCount': 89,
      'currentPrice': 21990000,
      'originalPrice': 25000000,
      'discountPercent': 12,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWQD_Gwm2nT99IxN-QY6QZ-oQieYymKPhObCM-7QId0A&s=10',
    },
    {
      'name': 'Áo khoác gió thể thao trượt nước cao cấp',
      'category': 'Thời trang',
      'rating': 4.6,
      'reviewCount': 45,
      'currentPrice': 320000,
      'originalPrice': 450000,
      'discountPercent': 28,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhKuVz5UgeWM8MupIcI3h6QpI8aALjAEPsZReHkeri5g&s=10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Lọc danh sách sản phẩm theo danh mục và từ khóa tìm kiếm
    final filteredProducts = _allProducts.where((product) {
      final matchesCategory = _selectedCategory == 'Tất cả' || product['category'] == _selectedCategory;
      final matchesSearch = product['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopEasy - Trang chủ'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          // Nút Đăng nhập dạng TextButton có Icon
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
          ),
          
          const SizedBox(width: 4),

          // Nút Đăng ký được làm nổi bật hơn với viền hoặc nền khác nhẹ
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
          // 2. Ô tìm kiếm bo tròn
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm sản phẩm...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF1F5F9),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 3. Hàng chip danh mục cuộn ngang
          Container(
            color: Colors.white,
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
                      selectedColor: const Color(0xFF2563EB),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF475569),
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: const Color(0xFFF1F5F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none,
                      ),
                      onSelected: (selected) {
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

          // 4. Lưới sản phẩm
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text('Không tìm thấy sản phẩm phù hợp', style: TextStyle(color: Colors.grey)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 cột
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.73, // Tỷ lệ chiều rộng/chiều cao của card
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
                          debugPrint('Đã thêm ${item['name']} vào giỏ hàng');
                        },
                        onFavoritePressed: () {
                          debugPrint('Đã bấm yêu thích sản phẩm');
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