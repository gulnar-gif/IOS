
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'product.dart';

const green = Color(0xFF256B4A);
const bg = Color(0xFFF4F9F5);

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int page = 0;

  void share() {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SelectableText(widget.product.deepLink),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: widget.product.deepLink),
                  );
                  if (!sheetContext.mounted) return;
                  Navigator.pop(sheetContext);
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copy Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final images = p.galleryImages;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        title: const Text(
          'AURA SELECT',
          style: TextStyle(
            color: green,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: share,
            icon: const Icon(Icons.share, color: green),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 270,
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: images.length,
                          onPageChanged: (i) => setState(() => page = i),
                          itemBuilder: (_, i) {
                            final photo = Image.network(
                              images[i],
                              fit: BoxFit.contain,
                              errorBuilder: (_, _, _) =>
                                  const Icon(Icons.broken_image),
                            );
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: i == 0
                                  ? Hero(
                                      tag: 'product_image_${p.id}',
                                      child: photo,
                                    )
                                  : photo,
                            );
                          },
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Chip(
                            label: Text('${page + 1} / ${images.length}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.all(4),
                        width: page == i ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: page == i ? green : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(label: Text(p.category)),
                  const SizedBox(height: 10),
                  Text(
                    p.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(' ${p.rating} (${p.reviewCount} reviews)'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '\$${p.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      color: green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 35),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(p.description),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: green,
              padding: const EdgeInsets.all(17),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${p.title} added to cart!')),
              );
            },
            icon: const Icon(Icons.shopping_bag_outlined),
            label: const Text('Add to Cart'),
          ),
        ),
      ),
    );
  }
}
