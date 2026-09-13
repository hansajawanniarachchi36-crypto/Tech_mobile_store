import 'package:flutter/material.dart';

void main() {
  runApp(const PhoneShopApp());
}

class PhoneShopApp extends StatelessWidget {
  const PhoneShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Store',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0F12),
        colorScheme: const ColorScheme.dark(
          primary: Colors.cyanAccent,
          surface: Color(0xFF181A20),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// Phone Data Model with imageUrl
class PhoneProduct {
  final String name;
  final String brand;
  final String price;
  final String rating;
  final String imageUrl; // Image URL
  final String ram;
  final String storage;
  final String battery;
  final String camera;
  final String description;

  PhoneProduct({
    required this.name,
    required this.brand,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.ram,
    required this.storage,
    required this.battery,
    required this.camera,
    required this.description,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String selectedCategory = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> categories = [
    'All',
    'Apple',
    'Samsung',
    'Xiaomi',
    'Google',
    'OnePlus',
  ];

  // Smartphone Dataset with Network Image URLs
  final List<PhoneProduct> allProducts = [
    // Apple
    PhoneProduct(
      name: 'iPhone 15 Pro Max',
      brand: 'Apple',
      price: '\$1,199',
      rating: '4.9',
      imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?q=80&w=500',
      ram: '8 GB',
      storage: '256GB / 512GB / 1TB',
      battery: '4422 mAh',
      camera: '48MP + 12MP + 12MP',
      description:
          'Titanium design with A17 Pro chip and customizable Action button.',
    ),
    PhoneProduct(
      name: 'iPhone 15 Pro',
      brand: 'Apple',
      price: '\$999',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?q=80&w=500',
      ram: '8 GB',
      storage: '128GB / 256GB / 512GB',
      battery: '3274 mAh',
      camera: '48MP + 12MP + 12MP',
      description: 'Lightweight titanium build with Pro camera system.',
    ),
    PhoneProduct(
      name: 'iPhone 15',
      brand: 'Apple',
      price: '\$799',
      rating: '4.7',
      imageUrl: 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?q=80&w=500',
      ram: '6 GB',
      storage: '128GB / 256GB',
      battery: '3349 mAh',
      camera: '48MP + 12MP Dual Camera',
      description: 'Dynamic Island, 48MP Main camera, and USB-C support.',
    ),
    PhoneProduct(
      name: 'iPhone 14 Pro Max',
      brand: 'Apple',
      price: '\$999',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1678685888221-cda773a3dcdb?q=80&w=500',
      ram: '6 GB',
      storage: '128GB / 256GB / 512GB',
      battery: '4323 mAh',
      camera: '48MP Triple Camera',
      description: 'Features Dynamic Island and Always-On display technology.',
    ),
    PhoneProduct(
      name: 'iPhone 13',
      brand: 'Apple',
      price: '\$599',
      rating: '4.6',
      imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=500',
      ram: '4 GB',
      storage: '128GB / 256GB',
      battery: '3240 mAh',
      camera: '12MP Dual Camera',
      description: 'Super Retina XDR display with Cinematic mode in 1080p.',
    ),

    // Samsung
    PhoneProduct(
      name: 'Galaxy S24 Ultra',
      brand: 'Samsung',
      price: '\$1,299',
      rating: '4.9',
      imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?q=80&w=500',
      ram: '12 GB',
      storage: '256GB / 512GB / 1TB',
      battery: '5000 mAh',
      camera: '200MP + 50MP + 12MP + 10MP',
      description: 'Galaxy AI is here. Integrated S Pen with Titanium Frame.',
    ),
    PhoneProduct(
      name: 'Galaxy S24+',
      brand: 'Samsung',
      price: '\$999',
      rating: '4.7',
      imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?q=80&w=500',
      ram: '12 GB',
      storage: '256GB / 512GB',
      battery: '4900 mAh',
      camera: '50MP + 10MP + 12MP',
      description: 'Enhanced QHD+ display with Snapdragon 8 Gen 3 for Galaxy.',
    ),
    PhoneProduct(
      name: 'Galaxy Z Fold 5',
      brand: 'Samsung',
      price: '\$1,799',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1584006682522-dc17d6c0d963?q=80&w=500',
      ram: '12 GB',
      storage: '256GB / 512GB',
      battery: '4400 mAh',
      camera: '50MP + 12MP + 10MP',
      description: 'Massive 7.6-inch main screen for ultimate multitasking.',
    ),
    PhoneProduct(
      name: 'Galaxy Z Flip 5',
      brand: 'Samsung',
      price: '\$999',
      rating: '4.6',
      imageUrl: 'https://images.unsplash.com/photo-1584006682522-dc17d6c0d963?q=80&w=500',
      ram: '8 GB',
      storage: '256GB / 512GB',
      battery: '3700 mAh',
      camera: '12MP Dual Camera',
      description: 'Compact pocket-sized design with Flex Window.',
    ),
    PhoneProduct(
      name: 'Galaxy A54 5G',
      brand: 'Samsung',
      price: '\$449',
      rating: '4.5',
      imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?q=80&w=500',
      ram: '8 GB',
      storage: '128GB / 256GB',
      battery: '5000 mAh',
      camera: '50MP + 12MP + 5MP',
      description: 'Awesome camera and smooth 120Hz Super AMOLED screen.',
    ),

    // Xiaomi
    PhoneProduct(
      name: 'Xiaomi 14 Ultra',
      brand: 'Xiaomi',
      price: '\$1,199',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '16 GB',
      storage: '512GB / 1TB',
      battery: '5300 mAh',
      camera: '50MP Quad Leica Cameras',
      description: 'Leica Quad Camera System with 1-inch sensor optical lens.',
    ),
    PhoneProduct(
      name: 'Xiaomi 14',
      brand: 'Xiaomi',
      price: '\$799',
      rating: '4.7',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '12 GB',
      storage: '256GB / 512GB',
      battery: '4610 mAh',
      camera: '50MP Triple Leica Camera',
      description: 'Compact size with Snapdragon 8 Gen 3 flagship processor.',
    ),
    PhoneProduct(
      name: 'Xiaomi 13T Pro',
      brand: 'Xiaomi',
      price: '\$649',
      rating: '4.6',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '12 GB',
      storage: '256GB / 512GB',
      battery: '5000 mAh',
      camera: '50MP Leica Camera',
      description: '144Hz CrystalRes AMOLED display with 120W HyperCharge.',
    ),
    PhoneProduct(
      name: 'Redmi Note 13 Pro+',
      brand: 'Xiaomi',
      price: '\$399',
      rating: '4.5',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '8 GB / 12 GB',
      storage: '256GB / 512GB',
      battery: '5000 mAh',
      camera: '200MP OIS Camera',
      description: '200MP ultra-clear camera with 120W Smart HyperCharge.',
    ),
    PhoneProduct(
      name: 'POCO F6 Pro',
      brand: 'Xiaomi',
      price: '\$499',
      rating: '4.6',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '12 GB',
      storage: '256GB / 512GB',
      battery: '5000 mAh',
      camera: '50MP Triple Camera',
      description: 'WQHD+ 120Hz Flow AMOLED with Snapdragon 8 Gen 2.',
    ),

    // Google
    PhoneProduct(
      name: 'Pixel 8 Pro',
      brand: 'Google',
      price: '\$999',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '12 GB',
      storage: '128GB / 256GB / 512GB',
      battery: '5050 mAh',
      camera: '50MP + 48MP + 48MP',
      description: 'Google Tensor G3 chip with specialized AI camera software.',
    ),
    PhoneProduct(
      name: 'Pixel 8',
      brand: 'Google',
      price: '\$699',
      rating: '4.7',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '8 GB',
      storage: '128GB / 256GB',
      battery: '4575 mAh',
      camera: '50MP + 12MP',
      description: 'Powerful everyday camera with Actua bright display.',
    ),
    PhoneProduct(
      name: 'Pixel 8a',
      brand: 'Google',
      price: '\$499',
      rating: '4.6',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '8 GB',
      storage: '128GB / 256GB',
      battery: '4492 mAh',
      camera: '64MP + 13MP',
      description:
          'Delivers high-end AI camera features at an affordable rate.',
    ),
    PhoneProduct(
      name: 'Pixel Fold',
      brand: 'Google',
      price: '\$1,799',
      rating: '4.5',
      imageUrl: 'https://images.unsplash.com/photo-1584006682522-dc17d6c0d963?q=80&w=500',
      ram: '12 GB',
      storage: '256GB / 512GB',
      battery: '4821 mAh',
      camera: '48MP + 10.8MP + 10.8MP',
      description:
          'The first foldable phone engineered by Google with Tensor G2.',
    ),
    PhoneProduct(
      name: 'Pixel 7a',
      brand: 'Google',
      price: '\$374',
      rating: '4.5',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '8 GB',
      storage: '128GB',
      battery: '4385 mAh',
      camera: '64MP Dual Camera',
      description: 'Incredible speed and security built with Google Tensor G2.',
    ),

    // OnePlus
    PhoneProduct(
      name: 'OnePlus 12',
      brand: 'OnePlus',
      price: '\$799',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?q=80&w=500',
      ram: '12 GB / 16 GB',
      storage: '256GB / 512GB',
      battery: '5400 mAh',
      camera: '50MP + 64MP + 48MP Hasselblad',
      description:
          'Smooth Beyond Belief with Snapdragon 8 Gen 3 and 100W charging.',
    ),
    PhoneProduct(
      name: 'OnePlus 12R',
      brand: 'OnePlus',
      price: '\$499',
      rating: '4.7',
      imageUrl: 'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?q=80&w=500',
      ram: '8 GB / 16 GB',
      storage: '128GB / 256GB',
      battery: '5500 mAh',
      camera: '50MP Triple Camera',
      description: 'Performance flagship featuring 4th Gen LTPO 120Hz display.',
    ),
    PhoneProduct(
      name: 'OnePlus Open',
      brand: 'OnePlus',
      price: '\$1,699',
      rating: '4.9',
      imageUrl: 'https://images.unsplash.com/photo-1584006682522-dc17d6c0d963?q=80&w=500',
      ram: '16 GB',
      storage: '512GB',
      battery: '4805 mAh',
      camera: '48MP + 64MP + 48MP Hasselblad',
      description:
          'Lightweight foldable powerhouse with Open Canvas multitasking.',
    ),
    PhoneProduct(
      name: 'OnePlus Nord 4',
      brand: 'OnePlus',
      price: '\$399',
      rating: '4.5',
      imageUrl: 'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?q=80&w=500',
      ram: '8 GB / 12 GB',
      storage: '128GB / 256GB',
      battery: '5500 mAh',
      camera: '50MP Sony OIS Camera',
      description: 'All-metal unibody design with 100W SUPERVOOC charging.',
    ),
    PhoneProduct(
      name: 'OnePlus 11 5G',
      brand: 'OnePlus',
      price: '\$699',
      rating: '4.7',
      imageUrl: 'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?q=80&w=500',
      ram: '8 GB / 16 GB',
      storage: '128GB / 256GB',
      battery: '5000 mAh',
      camera: '50MP Hasselblad Camera',
      description: 'Powered by Snapdragon 8 Gen 2 with Cryo-velocity cooling.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = allProducts.where((product) {
      final matchesCategory =
          selectedCategory == 'All' || product.brand == selectedCategory;
      final matchesSearch =
          product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.brand.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome back,',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'Tech Mobile Store 📱',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.cyanAccent,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search phones by name or brand...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF181A20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.cyan, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SPECIAL OFFER',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          '15% OFF on Flagship Models',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Shop Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.phone_iphone,
                    size: 70,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Brands Category Selector
            const Text(
              'Brands',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = category),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.cyanAccent
                            : const Color(0xFF181A20),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$selectedCategory Phones',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${filteredProducts.length} items',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Product Grid
            filteredProducts.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.remove_shopping_cart_outlined,
                          size: 70,
                          color: Colors.redAccent,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Out of Stock',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Sorry, the requested smartphone is currently unavailable.',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF181A20),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image displaying with Image.network
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    product.imageUrl,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              color: Colors.grey.shade900,
                                              child: const Icon(
                                                Icons.phone_android,
                                                size: 50,
                                                color: Colors.grey,
                                              ),
                                            ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                product.brand,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.price,
                                    style: const TextStyle(
                                      color: Colors.cyanAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        product.rating,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF181A20),
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Product Details Screen
class ProductDetailScreen extends StatelessWidget {
  final PhoneProduct product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Detailed Network Image
            Container(
              height: 280,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade900,
                    child: const Icon(
                      Icons.phone_android,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.brand,
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            product.rating,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Specifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSpecTile(Icons.memory, 'RAM', product.ram),
                      _buildSpecTile(
                        Icons.sd_storage,
                        'Storage',
                        product.storage,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSpecTile(
                        Icons.battery_charging_full,
                        'Battery',
                        product.battery,
                      ),
                      _buildSpecTile(
                        Icons.camera_alt,
                        'Camera',
                        product.camera,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(
                      color: Colors.grey,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF181A20),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Buy Now',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecTile(IconData icon, String title, String value) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF181A20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyanAccent, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
