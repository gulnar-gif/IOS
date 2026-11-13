
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';
import 'product_detail.dart';

void main() => runApp(const MyApp());

const green = Color(0xFF256B4A);
const bg = Color(0xFFF4F9F5);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: green,
      scaffoldBackgroundColor: bg,
    ),
    home: const StoreScreen(),
  );
}

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  List<Product> products = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final res = await http
          .get(Uri.parse('https://fakestoreapi.com/products'))
          .timeout(const Duration(seconds: 10));

      if (res.statusCode != 200) {
        throw Exception('Server error: ${res.statusCode}');
      }

      final data = jsonDecode(res.body) as List;
      if (!mounted) return;
      setState(() {
        products = data
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = 'Connection failed. Check your internet.';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: bg,
      centerTitle: true,
      title: const Text(
        'AURA SELECT',
        style: TextStyle(
          color: green,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      actions: [
        IconButton(
          onPressed: fetchProducts,
          icon: const Icon(Icons.refresh, color: green),
        ),
      ],
    ),
    body: loading
        ? const Center(child: CircularProgressIndicator())
        : error != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 65, color: green),
                    const SizedBox(height: 15),
                    Text(error!),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: fetchProducts,
                      child: const Text('Retry Connection'),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: fetchProducts,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length + 1,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Discover your style',
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: green,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('Explore our selected collection'),
                          ],
                        ),
                      );
                    }

                    final p = products[index - 1];

                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      shadowColor: Colors.green.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(product: p),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Hero(
                                tag: 'product_image_${p.id}',
                                child: Container(
                                  width: 95,
                                  height: 100,
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.white,
                                  child: Image.network(
                                    p.imageUrl,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, _, _) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.category.toUpperCase(),
                                      style: const TextStyle(
                                        color: green,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      p.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 17),
                                        Text(' ${p.rating}'),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      '\$${p.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
  );
}
