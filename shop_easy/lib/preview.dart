import 'package:flutter/material.dart';
import 'package:shop_easy/features/product/widgets/product_cart.dart';

void main() {
  runApp(const StandaloneWidgetApp());
}

/// App giả lập chỉ để xem trước UI của 1 widget độc lập
class StandaloneWidgetApp extends StatelessWidget {
  const StandaloneWidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Preview',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Màu nền nhẹ
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Xem trước UI: Product Cart Item'),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          // Bọc padding để ngắm card độc lập ở giữa màn hình
          child: SizedBox(
            width: 180,
            child: ProductCart(
              imageUrl: '', // Để trống sẽ hiển thị icon placeholder
                name: 'Giày Sneaker Thể Thao Nam Nữ Phong Cách',
                rating: 4.8,
                reviewCount: 128,
                currentPrice: 450000,
                originalPrice: 600000,
                discountPercent: 25,
                addToCart: () {
                  debugPrint('Đã bấm thêm vào giỏ hàng!');
                },
                onFavoritePressed: () {
                  debugPrint('Đã bấm yêu thích!');
                },
            ),
          ),
        ),
      ),
    );
  }
}
