import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_easy/features/product/widgets/product_cart.dart';

void main() {
  testWidgets('ProductCart renders and handles tap in constrained width', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 180,
              child: ProductCart(
                imageUrl: '',
                name: 'Giày Sneaker Thể Thao Nam Nữ',
                rating: 4.8,
                reviewCount: 128,
                currentPrice: 450000,
                originalPrice: 600000,
                discountPercent: 25,
                addToCart: () {},
                onFavoritePressed: () {},
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Thêm vào giỏ'));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
