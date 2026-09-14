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
      title: 'Tech Mobile Store',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0F12),
        colorScheme: const ColorScheme.dark(
          primary: Colors.cyanAccent,
          surface: Color(0xFF181A20),
        ),
      ),
      home: const MainTabScreen(),
    );
  }
}

// Phone Data Model
class PhoneProduct {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String rating;
  final String imageUrl;
  final String ram;
  final String storage;
  final String battery;
  final String camera;
  final String description;
  final bool inStock;

  PhoneProduct({
    required this.id,
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
    this.inStock = true,
  });
}

// Cart Item Model
class CartItem {
  final PhoneProduct product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// Main Navigation Tab Screen
class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;

  // App Global State (In-Memory Data Store)
  final List<CartItem> _cartItems = [];
  final List<PhoneProduct> _wishlistItems = [];

  // Dataset
  final List<PhoneProduct> _allProducts = [
    // Apple
    PhoneProduct(
      id: 'p1',
      name: 'iPhone 15 Pro Max',
      brand: 'Apple',
      price: 1199.00,
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
      id: 'p2',
      name: 'iPhone 15 Pro',
      brand: 'Apple',
      price: 999.00,
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?q=80&w=500',
      ram: '8 GB',
      storage: '128GB / 256GB / 512GB',
      battery: '3274 mAh',
      camera: '48MP + 12MP + 12MP',
      description: 'Lightweight titanium build with Pro camera system.',
    ),
    PhoneProduct(
      id: 'p3',
      name: 'iPhone 15',
      brand: 'Apple',
      price: 799.00,
      rating: '4.7',
      imageUrl: 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?q=80&w=500',
      ram: '6 GB',
      storage: '128GB / 256GB',
      battery: '3349 mAh',
      camera: '48MP + 12MP Dual Camera',
      description: 'Dynamic Island, 48MP Main camera, and USB-C support.',
    ),

    // Samsung
    PhoneProduct(
      id: 'p4',
      name: 'Galaxy S24 Ultra',
      brand: 'Samsung',
      price: 1299.00,
      rating: '4.9',
      imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?q=80&w=500',
      ram: '12 GB',
      storage: '256GB / 512GB / 1TB',
      battery: '5000 mAh',
      camera: '200MP + 50MP + 12MP + 10MP',
      description: 'Galaxy AI is here. Integrated S Pen with Titanium Frame.',
    ),
    PhoneProduct(
      id: 'p5',
      name: 'Galaxy Z Fold 5',
      brand: 'Samsung',
      price: 1799.00,
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1584006682522-dc17d6c0d963?q=80&w=500',
      ram: '12 GB',
      storage: '256GB / 512GB',
      battery: '4400 mAh',
      camera: '50MP + 12MP + 10MP',
      description: 'Massive 7.6-inch main screen for ultimate multitasking.',
    ),

    // Xiaomi
    PhoneProduct(
      id: 'p6',
      name: 'Xiaomi 14 Ultra',
      brand: 'Xiaomi',
      price: 1199.00,
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '16 GB',
      storage: '512GB / 1TB',
      battery: '5300 mAh',
      camera: '50MP Quad Leica Cameras',
      description: 'Leica Quad Camera System with 1-inch sensor optical lens.',
    ),

    // Google
    PhoneProduct(
      id: 'p7',
      name: 'Pixel 8 Pro',
      brand: 'Google',
      price: 999.00,
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=500',
      ram: '12 GB',
      storage: '128GB / 256GB / 512GB',
      battery: '5050 mAh',
      camera: '50MP + 48MP + 48MP',
      description: 'Google Tensor G3 chip with specialized AI camera software.',
    ),

    // OnePlus
    PhoneProduct(
      id: 'p8',
      name: 'OnePlus 12',
      brand: 'OnePlus',
      price: 799.00,
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?q=80&w=500',
      ram: '12 GB / 16 GB',
      storage: '256GB / 512GB',
      battery: '5400 mAh',
      camera: '50MP + 64MP + 48MP Hasselblad',
      description:
          'Smooth Beyond Belief with Snapdragon 8 Gen 3 and 100W charging.',
    ),
  ];

  // Helper Methods
  void _addToCart(PhoneProduct product) {
    setState(() {
      final index = _cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );
      if (index >= 0) {
        _cartItems[index].quantity++;
      } else {
        _cartItems.add(CartItem(product: product));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.cyanAccent,
          onPressed: () {
            setState(() {
              _currentIndex = 2; // Move to Cart tab
            });
          },
        ),
      ),
    );
  }

  void _toggleWishlist(PhoneProduct product) {
    setState(() {
      if (_wishlistItems.contains(product)) {
        _wishlistItems.remove(product);
      } else {
        _wishlistItems.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        products: _allProducts,
        wishlist: _wishlistItems,
        onAddToCart: _addToCart,
        onToggleWishlist: _toggleWishlist,
      ),
      WishlistScreen(
        wishlist: _wishlistItems,
        onAddToCart: _addToCart,
        onToggleWishlist: _toggleWishlist,
      ),
      CartScreen(
        cartItems: _cartItems,
        onQuantityChanged: () => setState(() {}),
        onRemove: (item) => setState(() => _cartItems.remove(item)),
        onClearCart: () => setState(() => _cartItems.clear()),
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF181A20),
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('${_wishlistItems.length}'),
              isLabelVisible: _wishlistItems.isNotEmpty,
              child: const Icon(Icons.favorite_outline),
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text(
                '${_cartItems.fold(0, (sum, item) => sum + item.quantity)}',
              ),
              isLabelVisible: _cartItems.isNotEmpty,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatefulWidget {
  final List<PhoneProduct> products;
  final List<PhoneProduct> wishlist;
  final Function(PhoneProduct) onAddToCart;
  final Function(PhoneProduct) onToggleWishlist;

  const HomeScreen({
    super.key,
    required this.products,
    required this.wishlist,
    required this.onAddToCart,
    required this.onToggleWishlist,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    final filteredProducts = widget.products.where((product) {
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search phones by name or brand...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => searchQuery = '');
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
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'SPECIAL OFFER',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '15% OFF on Flagship Models',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.phone_iphone,
                    size: 60,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Brands Filter
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
                  final cat = categories[index];
                  final isSelected = cat == selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = cat),
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
                        cat,
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

            // Grid View
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                final isWishlisted = widget.wishlist.contains(product);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: product,
                          isWishlisted: isWishlisted,
                          onAddToCart: widget.onAddToCart,
                          onToggleWishlist: widget.onToggleWishlist,
                        ),
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
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product.imageUrl,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: IconButton(
                                icon: Icon(
                                  isWishlisted
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isWishlisted
                                      ? Colors.redAccent
                                      : Colors.white,
                                ),
                                onPressed: () =>
                                    widget.onToggleWishlist(product),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.brand,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 4),
                            ),
                            onPressed: () => widget.onAddToCart(product),
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              size: 16,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
    );
  }
}

// Wishlist Screen
class WishlistScreen extends StatelessWidget {
  final List<PhoneProduct> wishlist;
  final Function(PhoneProduct) onAddToCart;
  final Function(PhoneProduct) onToggleWishlist;

  const WishlistScreen({
    super.key,
    required this.wishlist,
    required this.onAddToCart,
    required this.onToggleWishlist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: wishlist.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Your Wishlist is Empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF181A20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(color: Colors.cyanAccent),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.cyanAccent,
                        ),
                        onPressed: () => onAddToCart(product),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => onToggleWishlist(product),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// Cart Screen with Total Calculation
class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;
  final VoidCallback onQuantityChanged;
  final Function(CartItem) onRemove;
  final VoidCallback onClearCart;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.onClearCart,
  });

  @override
  Widget build(BuildContext context) {
    double subtotal = cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    double shipping = cartItems.isEmpty ? 0 : 15.0;
    double total = subtotal + shipping;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
              onPressed: onClearCart,
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your Cart is Empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF181A20),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.product.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$${item.product.price}',
                                    style: const TextStyle(
                                      color: Colors.cyanAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    if (item.quantity > 1) {
                                      item.quantity--;
                                      onQuantityChanged();
                                    } else {
                                      onRemove(item);
                                    }
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.cyanAccent,
                                  ),
                                  onPressed: () {
                                    item.quantity++;
                                    onQuantityChanged();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Order Summary Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF181A20),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '\$${subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Shipping Fee',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '\$${shipping.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(height: 24, color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyanAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: const Color(0xFF181A20),
                                title: const Text('Order Placed! 🎉'),
                                content: const Text(
                                  'Thank you for your order. Your smartphones are on the way!',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      onClearCart();
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                        color: Colors.cyanAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            'Proceed to Checkout',
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
              ],
            ),
    );
  }
}

// Product Detail Screen
class ProductDetailScreen extends StatelessWidget {
  final PhoneProduct product;
  final bool isWishlisted;
  final Function(PhoneProduct) onAddToCart;
  final Function(PhoneProduct) onToggleWishlist;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.isWishlisted,
    required this.onAddToCart,
    required this.onToggleWishlist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: isWishlisted ? Colors.redAccent : Colors.white,
            ),
            onPressed: () => onToggleWishlist(product),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand,
                    style: const TextStyle(
                      color: Colors.cyanAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.cyanAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Specifications',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _specTile('RAM', product.ram),
                      _specTile('Storage', product.storage),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _specTile('Battery', product.battery),
                      _specTile('Camera', product.camera),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(color: Colors.grey, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xFF181A20),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyanAccent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => onAddToCart(product),
          icon: const Icon(Icons.add_shopping_cart, color: Colors.black),
          label: const Text(
            'Add to Cart',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _specTile(String title, String val) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF181A20),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          Text(
            val,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// User Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.cyanAccent,
              child: Icon(Icons.person, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 12),
            const Text(
              'Hansaja Wanniarachchi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'hansaja@example.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.cyanAccent,
              ),
              title: const Text('My Orders'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.location_on_outlined,
                color: Colors.cyanAccent,
              ),
              title: const Text('Shipping Addresses'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.payment_outlined,
                color: Colors.cyanAccent,
              ),
              title: const Text('Payment Methods'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
                color: Colors.cyanAccent,
              ),
              title: const Text('Settings'),
              onTap: () {},
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
