import 'package:flutter/material.dart';
import 'package:shop_easy/core/utils/formatters.dart';

class ProductCart extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double rating;
  final double reviewCount;
  final double currentPrice;
  final double originalPrice;
  final int discountPercent;
  final VoidCallback addToCart;
  final VoidCallback onFavoritePressed;

  const ProductCart({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.currentPrice,
    required this.originalPrice,
    required this.discountPercent,
    required this.addToCart,
    required this.onFavoritePressed,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack chứa Ảnh, nhãn giảm giá và nút yêu thích
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.1,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: ((context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, color: Colors.grey,),
                  )),
                ),
              ), // Tỷ lệ khung hình ảnh
              // Nhãn giảm giá góc trái
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '-$discountPercent%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Nút yêu thích góc phải
                Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white.withOpacity(0.85),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.favorite_border, size: 16, color: Colors.grey),
                    onPressed: onFavoritePressed,
                  ),
                ),
              ),
            ],
          ),

          // Phần thông tin chi tiết
          Expanded(child: Padding(
            padding: const EdgeInsetsGeometry.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,                      
                      ),
                    ),
                    const SizedBox(height: 4,),
                    // Row đánh giá: sao, điểm, số lượng đánh giá
                    Row(
                      children: [
                        const Icon(Icons.star, size: 13, color: Colors.amber),
                          const SizedBox(width: 3),
                          Text(
                            '$rating',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '($reviewCount)',
                            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                          ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Giá 
                        Row(
                          children: [
                            Text(
                              AppFormatters.formatCurrency(currentPrice),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text(
                              AppFormatters.formatCurrency(originalPrice),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Nút add to cart

                            SizedBox(
                              width: double.infinity,
                              height: 30,
                              child: FilledButton(
                                onPressed: addToCart,
                                style: FilledButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text('Thêm vào giỏ', style: TextStyle(fontSize: 11)),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                  
                ),
              ],
            ),
            
            ))
        ],
      ),
    );
  }
}