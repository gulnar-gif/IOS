import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback onReset;

  const EmptyState({
    super.key,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 75,
            color: Color(0xFFB99D90),
          ),
          const SizedBox(height: 16),
          const Text(
            'Catalog is Empty',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF493A35),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'There are no products available.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onReset,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF75594F),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 13,
              ),
            ),
            child: const Text('Reset Catalog'),
          ),
        ],
      ),
    );
  }
}