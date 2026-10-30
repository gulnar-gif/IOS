import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String category;
  final double rating;
  final double price;
  final IconData icon;
  final Color color;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.rating,
    required this.price,
    required this.icon,
    required this.color,
  });

  static List<Product> seedProducts() {
    final names = [
      'Hydrating Face Cream',
      'Vitamin C Serum',
      'Gentle Face Cleanser',
      'Daily Sunscreen SPF 50',
      'Rose Face Toner',
      'Lip Care Balm',
      'Beauty Face Mask',
      'Aloe Vera Gel',
      'Night Repair Cream',
      'Hyaluronic Serum',
      'Body Lotion',
      'Soft Makeup Brush',
      'Cleansing Oil',
      'Eye Cream',
      'Face Scrub',
      'Hair Repair Mask',
      'Hand Cream',
      'Micellar Water',
      'Facial Mist',
      'Lip Gloss',
      'Moisturizing Gel',
      'Body Scrub',
      'Eye Patches',
      'Skin Care Set',
      'Makeup Remover',
      'Hair Oil',
      'Clay Face Mask',
      'Daily Face Wash',
      'Nourishing Cream',
      'Beauty Essentials Kit',
    ];

    final categories = [
      'Skincare',
      'Serum',
      'Cleanser',
      'Sun Care',
      'Toner',
      'Lip Care',
      'Mask',
      'Skincare',
      'Cream',
      'Serum',
    ];

    final icons = [
      Icons.spa_outlined,
      Icons.water_drop_outlined,
      Icons.cleaning_services_outlined,
      Icons.wb_sunny_outlined,
      Icons.local_florist_outlined,
    ];

    final colors = [
      Color(0xFFF2D9D0),
      Color(0xFFE9DCCB),
      Color(0xFFDCE7DF),
      Color(0xFFF3E5C8),
      Color(0xFFE8DCEF),
    ];

    return List.generate(names.length, (index) {
      return Product(
        id: 'product_$index',
        title: names[index],
        category: categories[index % categories.length],
        rating: 4.2 + (index % 8) / 10,
        price: 2500 + (index * 350).toDouble(),
        icon: icons[index % icons.length],
        color: colors[index % colors.length],
      );
    });
  }
}