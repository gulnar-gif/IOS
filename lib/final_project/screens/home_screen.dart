
import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  String selectedCategory = 'All';
  String searchText = '';

  final Set<String> favorites = {};
  final List<FurnitureProduct> cart = [];

  final List<String> categories = [
    'All',
    'Bedroom',
    'Living Room',
    'Dining Room',
    'Office',
  ];

  final List<FurnitureProduct> products = const [
    FurnitureProduct(
      id: 'rixos',
      name: 'RIXOS Bedroom Set',
      category: 'Bedroom',
      description:
          'The RIXOS bedroom set combines elegant design, '
          'comfortable living and a modern furniture style. '
          'A beautiful choice for your dream bedroom.',
      price: 450000,
      rating: 4.9,
      icon: Icons.bed,
      image: 'assets/images/rixos.png',
    ),
    FurnitureProduct(
      id: 'sofa',
      name: 'Luna Sofa',
      category: 'Living Room',
      description:
          'A stylish and comfortable sofa for a modern '
          'living room. Perfect for relaxing with family.',
      price: 285000,
      rating: 4.8,
      icon: Icons.weekend,
    ),
  ];

  void toggleFavorite(FurnitureProduct product) {
    setState(() {
      if (favorites.contains(product.id)) {
        favorites.remove(product.id);
      } else {
        favorites.add(product.id);
      }
    });
  }

  void addToCart(FurnitureProduct product) {
    setState(() {
      cart.add(product);
    });
  }

  void openDetails(FurnitureProduct product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: product,
          isFavorite: favorites.contains(product.id),
          onFavorite: () => toggleFavorite(product),
          onAddCart: () => addToCart(product),
        ),
      ),
    );
  }

  List<FurnitureProduct> get filteredProducts {
    return products.where((product) {
      final categoryMatches =
          selectedCategory == 'All' ||
          product.category == selectedCategory;

      final searchMatches = product.name
          .toLowerCase()
          .contains(searchText.toLowerCase());

      return categoryMatches && searchMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: SafeArea(
        child: IndexedStack(
          index: selectedTab,
          children: [
            _homePage(),
            _favoritesPage(),
            _cartPage(),
            _profilePage(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE9D9C8),
        height: 72,
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _homePage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
      children: [
        _header(),
        const SizedBox(height: 26),
        const Text(
          'Find your perfect',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'furniture',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Color(0xFF957356),
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search furniture...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFFE8D6C0),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NEW COLLECTION',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 2,
                        color: Color(0xFF755943),
                      ),
                    ),
                    SizedBox(height: 9),
                    Text(
                      'Make your home\nbeautiful',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Explore our furniture',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.weekend_rounded,
                size: 90,
                color: Color(0xFF957356),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        _sectionTitle('Categories'),
        const SizedBox(height: 13),
        SizedBox(
          height: 43,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) =>
                const SizedBox(width: 9),
            itemBuilder: (context, index) {
              final category = categories[index];
              final selected =
                  selectedCategory == category;

              return ChoiceChip(
                label: Text(category),
                selected: selected,
                onSelected: (_) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                selectedColor: const Color(0xFF77543C),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: selected
                      ? Colors.white
                      : const Color(0xFF554738),
                ),
                showCheckmark: false,
                side: BorderSide.none,
              );
            },
          ),
        ),
        const SizedBox(height: 28),
        _sectionTitle('Popular Furniture'),
        const SizedBox(height: 16),
        _productGrid(filteredProducts),
      ],
    );
  }

  Widget _header() {
    return Row(
      children: [
        const Icon(
          Icons.chair_alt_rounded,
          size: 31,
          color: Color(0xFF77543C),
        ),
        const SizedBox(width: 8),
        const Text(
          'EDEM',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            letterSpacing: 3,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            setState(() {
              selectedTab = 2;
            });
          },
          icon: Badge(
            isLabelVisible: cart.isNotEmpty,
            label: Text('${cart.length}'),
            child: const Icon(
              Icons.shopping_bag_outlined,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _productGrid(List<FurnitureProduct> items) {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(35),
        child: Center(
          child: Text('No furniture found'),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 330,
          ),
          itemBuilder: (context, index) {
            final product = items[index];

            return ProductCard(
              product: product,
              isFavorite:
                  favorites.contains(product.id),
              onTap: () => openDetails(product),
              onFavorite: () =>
                  toggleFavorite(product),
            );
          },
        );
      },
    );
  }

  Widget _favoritesPage() {
    final items = products
        .where((p) => favorites.contains(p.id))
        .toList();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionTitle('My Favorites'),
        const SizedBox(height: 20),
        if (items.isEmpty)
          _emptyState(
            Icons.favorite_border,
            'No favorites yet',
          )
        else
          _productGrid(items),
      ],
    );
  }

  Widget _cartPage() {
    int total = 0;

    for (final product in cart) {
      total += product.price;
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _sectionTitle('My Cart'),
        const SizedBox(height: 20),
        if (cart.isEmpty)
          _emptyState(
            Icons.shopping_bag_outlined,
            'Your cart is empty',
          )
        else ...[
          for (int i = 0; i < cart.length; i++)
            Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  cart[i].icon,
                  color: const Color(0xFF77543C),
                ),
                title: Text(cart[i].name),
                subtitle: Text(
                  formatPrice(cart[i].price),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () {
                    setState(() {
                      cart.removeAt(i);
                    });
                  },
                ),
              ),
            ),
          const SizedBox(height: 22),
          Text(
            'Total: ${formatPrice(total)}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    'Checkout is a demo feature',
                  ),
                ),
              );
            },
            child: const Text('Checkout'),
          ),
        ],
      ],
    );
  }

 
 
Widget _profilePage() {
  return const SizedBox.expand();
}


  Widget _emptyState(
    IconData icon,
    String message,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Icon(
            icon,
            size: 75,
            color: const Color(0xFFCBB9A4),
          ),
          const SizedBox(height: 15),
          Text(
            message,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
