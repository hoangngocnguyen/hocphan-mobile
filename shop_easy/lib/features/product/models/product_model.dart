class Product {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final List<String> images;
  final double price;
  final double discountPercentage;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.images,
    required this.price,
    required this.discountPercentage,
    required this.rating,
  });

  /// Giá sau khi giảm = price * (1 - discountPercentage / 100)
  double get finalPrice => price * (1 - discountPercentage / 100);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'images': images,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
    };
  }
}
