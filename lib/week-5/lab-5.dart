
import 'package:flutter/material.dart';

void main() {
  runApp(const EdemApp());
}

class EdemApp extends StatelessWidget {
  const EdemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EDEM Furniture',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorSchemeSeed: Colors.brown,
      ),
      home: const ProductScreen(),
    );
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isFavorite = false;
  int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),

      appBar: AppBar(
        title: const Text(
          'EDEM Furniture',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF795548),
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/rixos.png',
                        width: double.infinity,
                        height: screenWidth < 400 ? 200 : 280,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 220,
                            color: Colors.brown.shade100,
                            child: const Center(
                              child: Text('RIXOS Image'),
                            ),
                          );
                        },
                      ),
                    ),

                    Positioned(
                      top: 12,
                      right: 12,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: const Color(0xFF795548),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                
                const Text(
                  'RIXOS Bedroom Set',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                    color: Color(0xFF2D2420),
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'EDEM Furniture Collection',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8D817A),
                    letterSpacing: 0.2,
                  ),
                ),

                const SizedBox(height: 18),

                
                const Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 22,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '4.8',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '450 000 ₸',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF795548),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text('Bedroom')),
                    Chip(label: Text('Modern')),
                    Chip(label: Text('RIXOS')),
                    Chip(label: Text('Furniture Set')),
                  ],
                ),

                const SizedBox(height: 24),

                
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2420),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'RIXOS is a modern bedroom furniture set '
                  'by EDEM Furniture. It is designed to make '
                  'your bedroom comfortable and beautiful. '
                  'The collection includes a bed, wardrobe, '
                  'dressing table, and bedside cabinet.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Color(0xFF444444),
                  ),
                ),

                const SizedBox(height: 24),

                // Included furniture
                const Text(
                  'Included Furniture',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2420),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  '• Bed\n'
                  '• Wardrobe\n'
                  '• Dressing Table\n'
                  '• Bedside Cabinet',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.9,
                    color: Color(0xFF444444),
                  ),
                ),

                const SizedBox(height: 24),

                // Dimensions
                const Text(
                  'Product Dimensions (mm)',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2420),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Wardrobe: 2400 × 2150 × 520\n'
                  'Dressing Table: 1020 × 1700 × 480\n'
                  'Bedside Cabinet: 600 × 1100 × 380\n'
                  'Bed: 1800 × 1500 × 2040',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.8,
                    color: Color(0xFF444444),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cartCount++;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'RIXOS added to cart! Total: $cartCount',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF795548),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
