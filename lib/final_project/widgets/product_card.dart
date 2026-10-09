
import 'package:flutter/material.dart';

class FurnitureProduct {
  final String id;
  final String name;
  final String category;
  final String description;
  final int price;
  final double rating;
  final IconData icon;
  final String? image;

  const FurnitureProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.rating,
    required this.icon,
    this.image,
  });
}

String formatPrice(int price) {
  String number = price.toString();
  String result = '';

  for (int i = 0; i < number.length; i++) {
    if (i > 0 && (number.length - i) % 3 == 0) {
      result += ' ';
    }
    result += number[i];
  }

  return '$result tg';
}

class ProductPicture extends StatelessWidget {
  final FurnitureProduct product;

  const ProductPicture({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.image != null) {
      return Image.asset(
        product.image!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return _placeholder();
        },
      );
    }

    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF1E9DD),
            Color(0xFFDCC8AF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          product.icon,
          size: 65,
          color: const Color(0xFF987D61),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final FurnitureProduct product;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.05,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ProductPicture(product: product),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: IconButton(
                        constraints: const BoxConstraints(
                          minWidth: 35,
                          minHeight: 35,
                        ),
                        padding: EdgeInsets.zero,
                        iconSize: 19,
                        onPressed: onFavorite,
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : const Color(0xFF554738),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFD4A13C),
                        size: 15,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatPrice(product.price),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C5738),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
