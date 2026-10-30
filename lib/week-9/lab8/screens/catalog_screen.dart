import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_list_item.dart';
import '../widgets/product_grid_card.dart';
import '../widgets/empty_state.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<Product> products = Product.seedProducts();

  bool isGridView = false;

  Future<void> _refreshProducts() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final newProduct = Product(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: 'New Beauty Product',
      category: 'New Arrival',
      rating: 4.9,
      price: 5990,
      icon: Icons.spa_outlined,
      color: const Color(0xFFE9DCCB),
    );

    setState(() {
      products.insert(0, newProduct);
    });
  }

  void _resetCatalog() {
    setState(() {
      products = Product.seedProducts();
    });
  }

  Widget _buildDismissible(Product product, int index) {
    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 25),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 25),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          products.removeAt(index);
        });

        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} deleted'),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                setState(() {
                  final restoreIndex =
                      index > products.length ? products.length : index;

                  products.insert(restoreIndex, product);
                });
              },
            ),
          ),
        );
      },
      child: isGridView
          ? ProductGridCard(product: product)
          : ProductListItem(product: product),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: EmptyState(onReset: _resetCatalog),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: products.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 2);
      },
      itemBuilder: (context, index) {
        final product = products[index];

        return _buildDismissible(product, index);
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return _buildDismissible(product, index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5F1),
        elevation: 0,
        title: const Text(
          'Glow Beauty',
          style: TextStyle(
            color: Color(0xFF493A35),
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        actions: [
          IconButton(
            tooltip: isGridView ? 'List View' : 'Grid View',
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
            icon: Icon(
              isGridView ? Icons.view_list : Icons.grid_view,
              color: const Color(0xFF75594F),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 12),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Discover Beauty Products',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF75594F),
                    ),
                  ),
                ),
                Text(
                  '${products.length} products',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: const Color(0xFF75594F),
              onRefresh: _refreshProducts,
              child: products.isEmpty
                  ? _buildEmptyState()
                  : isGridView
                      ? _buildGridView()
                      : _buildListView(),
            ),
          ),
        ],
      ),
    );
  }
}