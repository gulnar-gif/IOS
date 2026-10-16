
import 'package:flutter/material.dart';

void main() {
  runApp(const GlowMuseApp());
}

const dark = Color(0xFF252238);
const purple = Color(0xFF795F99);
const coral = Color(0xFFF47870);
const background = Color(0xFFFAF9F7);
const lavender = Color(0xFFEAE2F6);
const grey = Color(0xFF898491);

class BeautyProduct {
  final int id;
  final String name;
  final String category;
  final String description;
  final String image;
  final int price;
  final double rating;
  final Color color;

  const BeautyProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
    required this.color,
  });
}

const products = [
  BeautyProduct(
    id: 1,
    name: 'Hydra Glow Serum',
    category: 'Serum',
    description:
        'A lightweight facial serum that helps your skin feel '
        'hydrated, soft and refreshed. Perfect for everyday care.',
    image:
        'https://images.pexels.com/photos/4841167/pexels-photo-4841167.jpeg?auto=compress&cs=tinysrgb&w=900',
    price: 6900,
    rating: 4.9,
    color: Color(0xFFEAE2F6),
  ),
  BeautyProduct(
    id: 2,
    name: 'Rose Cloud Cream',
    category: 'Cream',
    description:
        'A soft and rich face cream for a beautiful skincare '
        'routine. Leaves your skin feeling smooth and comfortable.',
    image:
        'https://images.pexels.com/photos/10825661/pexels-photo-10825661.jpeg?auto=compress&cs=tinysrgb&w=900',
    price: 7500,
    rating: 4.8,
    color: Color(0xFFFFE5E0),
  ),
  BeautyProduct(
    id: 3,
    name: 'Daily SPF 50',
    category: 'Sun Care',
    description:
        'A daily facial sunscreen with SPF 50. '
        'An essential product for your morning skincare routine.',
    image:
        'https://images.pexels.com/photos/31251033/pexels-photo-31251033.jpeg?auto=compress&cs=tinysrgb&w=900',
    price: 5200,
    rating: 4.9,
    color: Color(0xFFE2EDDF),
  ),
  BeautyProduct(
    id: 4,
    name: 'Soft Clean Gel',
    category: 'Cleanser',
    description:
        'A gentle cleansing gel for everyday use. '
        'Wash away the day and leave your skin feeling fresh.',
    image:
        'https://images.pexels.com/photos/7817511/pexels-photo-7817511.jpeg?auto=compress&cs=tinysrgb&w=900',
    price: 4800,
    rating: 4.7,
    color: Color(0xFFE1EDF8),
  ),
];

String priceText(int price) {
  return '${price ~/ 1000} ${(price % 1000).toString().padLeft(3, '0')} ₸';
}

Widget productImage(BeautyProduct product) {
  return Image.network(
    product.image,
    width: double.infinity,
    height: double.infinity,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        color: product.color,
        child: const Center(
          child: Icon(
            Icons.spa_outlined,
            color: purple,
            size: 55,
          ),
        ),
      );
    },
  );
}

class GlowMuseApp extends StatelessWidget {
  const GlowMuseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlowMuse',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          foregroundColor: dark,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;
  String selectedCategory = 'All';
  String search = '';
  bool notifications = true;

  final Set<int> favorites = {};

  bool isFavorite(BeautyProduct product) {
    return favorites.contains(product.id);
  }

  void toggleFavorite(BeautyProduct product) {
    setState(() {
      if (isFavorite(product)) {
        favorites.remove(product.id);
      } else {
        favorites.add(product.id);
      }
    });
  }

  void openDetail(BeautyProduct product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          product: product,
          isFavorite: () => isFavorite(product),
          onFavorite: () => toggleFavorite(product),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedTab,
          children: [
            feedPage(),
            favoritesPage(),
            profilePage(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 18,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: selectedTab,
          onTap: (index) {
            setState(() {
              selectedTab = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: purple,
          unselectedItemColor: grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              activeIcon: Icon(Icons.favorite_rounded),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget pageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GLOWMUSE.',
              style: TextStyle(
                color: dark,
                fontSize: 27,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'YOUR DAILY BEAUTY EDIT',
              style: TextStyle(
                color: purple,
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedTab = 2;
            });
          },
          child: Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: lavender,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: dark,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }

  Widget beautyBanner() {
    return Container(
      height: 205,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: dark,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 150,
            child: productImage(products[0]),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    dark,
                    dark,
                    Color(0x00252238),
                  ],
                  stops: [0, 0.45, 1],
                ),
              ),
            ),
          ),
          Positioned(
            top: 23,
            left: 20,
            right: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'THE NEW SKIN EDIT',
                  style: TextStyle(
                    color: Color(0xFFE6CFFF),
                    fontSize: 10,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 17),
                const Text(
                  'Glow is\npersonal.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Meet your daily essentials.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => openDetail(products[0]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: coral,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      'Explore now  ↗',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          search = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search your next favorite...',
        hintStyle: const TextStyle(
          color: grey,
          fontSize: 14,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: purple,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget categoryButton(String name) {
    final active = selectedCategory == name;

    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: ChoiceChip(
        label: Text(name),
        selected: active,
        showCheckmark: false,
        backgroundColor: lavender,
        selectedColor: dark,
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        labelStyle: TextStyle(
          color: active ? Colors.white : dark,
          fontWeight: FontWeight.w600,
        ),
        onSelected: (value) {
          setState(() {
            selectedCategory = name;
          });
        },
      ),
    );
  }

  Widget productCard(BeautyProduct product) {
    return Material(
      color: product.color,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openDetail(product),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 158,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: productImage(product),
                    ),
                    Positioned(
                      top: 7,
                      right: 7,
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: IconButton(
                          iconSize: 20,
                          constraints: const BoxConstraints(
                            minWidth: 38,
                            minHeight: 38,
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            toggleFavorite(product);
                          },
                          icon: Icon(
                            isFavorite(product)
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFavorite(product)
                                ? coral
                                : dark,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 11),
              Text(
                '0${product.id} / ${product.category.toUpperCase()}',
                style: const TextStyle(
                  color: purple,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: dark,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      priceText(product.price),
                      style: const TextStyle(
                        color: dark,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFE1A347),
                    size: 17,
                  ),
                  Text(
                    '${product.rating}',
                    style: const TextStyle(
                      color: dark,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productGrid(List<BeautyProduct> list) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                constraints.maxWidth < 320 ? 1 : 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            mainAxisExtent: 272,
          ),
          itemBuilder: (context, index) {
            return productCard(list[index]);
          },
        );
      },
    );
  }

  Widget feedPage() {
    final visible = products.where((product) {
      final matchesCategory =
          selectedCategory == 'All' ||
          product.category == selectedCategory;

      final matchesSearch = product.name
          .toLowerCase()
          .contains(search.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 25),
      children: [
        pageHeader(),
        const SizedBox(height: 25),
        beautyBanner(),
        const SizedBox(height: 20),
        searchBar(),
        const SizedBox(height: 28),
        const Text(
          'BEAUTY, YOUR WAY',
          style: TextStyle(
            color: coral,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Find your thing.',
          style: TextStyle(
            color: dark,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 17),
        SizedBox(
          height: 53,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              categoryButton('All'),
              categoryButton('Serum'),
              categoryButton('Cream'),
              categoryButton('Sun Care'),
              categoryButton('Cleanser'),
            ],
          ),
        ),
        const SizedBox(height: 23),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'The beauty shelf',
              style: TextStyle(
                color: dark,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '${visible.length} products',
              style: const TextStyle(
                color: grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (visible.isEmpty)
          const Padding(
            padding: EdgeInsets.all(45),
            child: Center(
              child: Text(
                'No products found',
                style: TextStyle(color: grey),
              ),
            ),
          )
        else
          productGrid(visible),
      ],
    );
  }

  Widget favoritesPage() {
    final saved = products.where(isFavorite).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
      children: [
        const Text(
          'YOUR PERSONAL EDIT',
          style: TextStyle(
            color: coral,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Loved by you ♡',
          style: TextStyle(
            color: dark,
            fontSize: 31,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${saved.length} saved beauty essentials',
          style: const TextStyle(
            color: grey,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 25),
        if (saved.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 45,
            ),
            decoration: BoxDecoration(
              color: lavender,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.favorite_border_rounded,
                  color: purple,
                  size: 65,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Your wishlist is empty',
                  style: TextStyle(
                    color: dark,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Save the products you love.',
                  style: TextStyle(color: grey),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: dark,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTab = 0;
                    });
                  },
                  child: const Text('Explore products'),
                ),
              ],
            ),
          )
        else
          ...saved.map(
            (product) => Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: Material(
                color: product.color,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => openDetail(product),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 115,
                        height: 125,
                        child: productImage(product),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.category.toUpperCase(),
                              style: const TextStyle(
                                color: purple,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              product.name,
                              style: const TextStyle(
                                color: dark,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              priceText(product.price),
                              style: const TextStyle(
                                color: dark,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          toggleFavorite(product);
                        },
                        icon: const Icon(
                          Icons.favorite_rounded,
                          color: coral,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget profilePage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
      children: [
        const Text(
          'MY BEAUTY SPACE',
          style: TextStyle(
            color: coral,
            letterSpacing: 2,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Hello, beautiful.',
          style: TextStyle(
            color: dark,
            fontSize: 31,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(23),
          decoration: BoxDecoration(
            color: dark,
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 39,
                backgroundColor: lavender,
                child: Icon(
                  Icons.person_outline_rounded,
                  color: purple,
                  size: 43,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Beauty Lover',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'GLOWMUSE MEMBER',
                style: TextStyle(
                  color: Color(0xFFE6CFFF),
                  letterSpacing: 2,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Your glow, your story.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Your account',
          style: TextStyle(
            color: dark,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.favorite_border,
                  color: purple,
                ),
                title: const Text('Saved products'),
                trailing: Text('${favorites.length}  ›'),
                onTap: () {
                  setState(() {
                    selectedTab = 1;
                  });
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                secondary: const Icon(
                  Icons.notifications_none,
                  color: purple,
                ),
                title: const Text('Notifications'),
                subtitle: const Text('Demo preference'),
                value: notifications,
                activeThumbColor: purple,
                onChanged: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
              ),
              const Divider(height: 1),
              const ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: purple,
                ),
                title: Text('About GlowMuse'),
                subtitle: Text(
                  'Flutter Lab 7 - Navigation & Tabs',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const Center(
          child: Text(
            'GLOW IN YOUR OWN WAY',
            style: TextStyle(
              color: grey,
              fontSize: 11,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}

class DetailScreen extends StatefulWidget {
  final BeautyProduct product;
  final bool Function() isFavorite;
  final VoidCallback onFavorite;

  const DetailScreen({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavorite,
  });

  @override
  State<DetailScreen> createState() {
    return _DetailScreenState();
  }
}

class _DetailScreenState extends State<DetailScreen> {
  void toggleFavorite() {
    widget.onFavorite();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'THE BEAUTY EDIT',
          style: TextStyle(
            color: dark,
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: toggleFavorite,
            icon: Icon(
              widget.isFavorite()
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: widget.isFavorite() ? coral : dark,
            ),
          ),
          const SizedBox(width: 7),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: product.color,
              borderRadius: BorderRadius.circular(27),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: SizedBox(
                height: 300,
                child: productImage(product),
              ),
            ),
          ),
          const SizedBox(height: 26),
          Text(
            '0${product.id} / ${product.category.toUpperCase()}',
            style: const TextStyle(
              color: coral,
              letterSpacing: 2,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            style: const TextStyle(
              color: dark,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 11),
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: Color(0xFFE1A347),
                size: 23,
              ),
              Text(
                ' ${product.rating}  ·  GlowMuse collection',
                style: const TextStyle(
                  color: grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(19),
            decoration: BoxDecoration(
              color: lavender,
              borderRadius: BorderRadius.circular(19),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'PRICE',
                  style: TextStyle(
                    color: purple,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  priceText(product.price),
                  style: const TextStyle(
                    color: dark,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Why you will love it',
            style: TextStyle(
              color: dark,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            product.description,
            style: const TextStyle(
              color: grey,
              fontSize: 15,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 56,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: dark,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text(
                'Back to products',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
