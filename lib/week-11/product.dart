
class Product {
  final int id, reviewCount;
  final String title, description, category, imageUrl;
  final double price, rating;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final r = json['rating'];
    final rating = r is Map ? r : {};
    return Product(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? 'Unknown',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (rating['rate'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (rating['count'] as num?)?.toInt() ?? 0,
    );
  }

  List<String> get galleryImages => [imageUrl, imageUrl, imageUrl];
  String get deepLink => 'narxoz://store/product/$id';
}
