
import 'package:flutter/material.dart';
import '../widgets/product_card.dart';

class ProductDetailScreen extends StatefulWidget {
  final FurnitureProduct product;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onAddCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavorite,
    required this.onAddCart,
  });

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {
  late bool favorite;

  @override
  void initState() {
    super.initState();
    favorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 320,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ProductPicture(
                              product: product,
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: _roundButton(
                              Icons.arrow_back,
                              () => Navigator.pop(context),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: _roundButton(
                              favorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              () {
                                setState(() {
                                  favorite = !favorite;
                                });
                                widget.onFavorite();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.category.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF9B8066),
                              letterSpacing: 2,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Color(0xFFD4A13C),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${product.rating} / 5.0',
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Premium Collection',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            formatPrice(product.price),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF79563C),
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF77716A),
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 24),
                        
                      
                          const Wrap(
                            spacing: 9,
                            runSpacing: 9,
                            children: [
                              Chip(
                                label: Text('Modern design'),
                              ),
                              Chip(
                                label: Text('Comfort'),
                              ),
                              Chip(
                                label: Text('Premium style'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(
                20, 12, 20, 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      formatPrice(product.price),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.onAddCart();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Product added to cart!',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                      ),
                      label: const Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF77543C),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
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

  Widget _roundButton(
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}
