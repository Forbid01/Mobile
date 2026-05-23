import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import '../viewmodels/cart_view_model.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<String> _bannerImages = [
    'assets/images/Aqua1.png',
    'assets/images/Aqua1.png',
    'assets/images/Aqua1.png',
    'assets/images/Aqua1.png',
  ];

  final PageController _bannerController = PageController();
  int _currentBanner = 0;
  Timer? _bannerTimer;

  @override
  void initState() {
    super.initState();
    CartViewModel.instance.addListener(_onCartChanged);
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_bannerController.hasClients) return;
      final next = (_currentBanner + 1) % _bannerImages.length;
      _bannerController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    CartViewModel.instance.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    if (mounted) setState(() {});
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CartScreen()),
    );
  }

  void _addTeaToCart() {
    CartViewModel.instance.addItem(
      id: 'tea-product',
      name: 'Энхжин булцуут цэцгийн цай',
      imagePath: 'assets/images/tea.png',
      price: 12000,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Сагсанд нэмэгдлээ'),
        duration: Duration(milliseconds: 900),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopChips(),
              _buildBannerCarousel(),
              _buildActionButtons(),
              _buildSectionHeader("АНГИЛАЛ"),
              _buildHorizontalCategories(),
              _buildSectionHeader("МОНОС ОНООГООР АВАХ"),
              _buildProductGrid(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final cartCount = CartViewModel.instance.totalQuantity;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black87),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      title: Row(
        children: [
          const Text(
            "1,000 ",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 106, 0),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(color: Color.fromARGB(255, 255, 106, 0), width: 2),
              ),
            ),
            child: const Text(
              "P",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 106, 0),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.black87),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border, color: Colors.black87),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: _CartIconButton(
            count: cartCount,
            onPressed: _openCart,
          ),
        ),
      ],
    );
  }

  Widget _buildTopChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _chip("Нүүр", Image.asset("assets/images/gal.png"), true,
              const Color.fromARGB(255, 255, 106, 0)),
          _chip("Эм", Image.asset("assets/images/drug.png"), false,
              const Color(0xFF00A65A)),
          _chip("Гоо сайхан", Image.asset("assets/images/goo.png"), false,
              const Color(0xFF00A65A)),
          _chip("Ээж ба хүүхэд", const Icon(Icons.child_care, size: 18),
              false, const Color(0xFF00A65A)),
        ],
      ),
    );
  }

  Widget _chip(
      String label, Widget iconWidget, bool isSelected, Color activeColor) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? Border.all(color: activeColor) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 18, height: 18, child: iconWidget),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? activeColor : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 300,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.blue.shade100,
              child: PageView.builder(
                controller: _bannerController,
                itemCount: _bannerImages.length,
                onPageChanged: (i) => setState(() => _currentBanner = i),
                itemBuilder: (context, index) => Image.asset(
                  _bannerImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (c, e, s) =>
                      Container(color: Colors.blue.shade100),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _bannerImages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: index == _currentBanner ? 16 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: index == _currentBanner
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildShadowedButton(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Image.asset("assets/images/EMD.png", width: 20, height: 20),
              label: const Text("ЭМД",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold)),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Color(0xFF00A65A), width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildShadowedButton(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Image.asset("assets/images/upload.png",
                  width: 16, height: 16),
              label: const Text("Жор илгээх",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold)),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: Colors.grey.shade300, width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShadowedButton({required Widget child}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 0.5)),
          const Icon(Icons.arrow_forward, size: 20, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _buildHorizontalCategories() {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _categoryCard("Хүнс", "assets/images/food.png"),
          _categoryCard("Гоо сайхан", "assets/images/health.png"),
          _categoryCard("Ээж хүүхэд", "assets/images/children.png"),
          _categoryCard("Витамин", "assets/images/vitamin.png"),
          _categoryCard("Хүнс2", "assets/images/food.png"),
          _categoryCard("Гоо сайхан", "assets/images/health.png"),
          _categoryCard("Ээж хүүхэд", "assets/images/children.png"),
          _categoryCard("Витамин", "assets/images/vitamin.png"),
        ],
      ),
    );
  }

  Widget _categoryCard(String title, String imagePath) {
    return Container(
      width: 90,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          Text(title,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: 8,
      itemBuilder: (context, index) => _buildSingleProductCard(),
    );
  }

  Widget _buildSingleProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 90,
                    width: 100,
                    child: Image.asset(
                      "assets/images/tea.png",
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey),
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  "Энхжин булцуут цэцгийн цай",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(
                        text: "12,000",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const WidgetSpan(child: SizedBox(width: 4)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Image.asset("assets/images/Vector.png",
                          height: 12,
                          width: 12,
                          errorBuilder: (context, error, stackTrace) =>
                              const Text("₮",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold))),
                    ),
                  ]),
                ),
                Text(
                  "42,000₮",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: const BoxDecoration(
                color: Color(0xFF00E676),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: const Text("ШИНЭ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const Positioned(
            top: 12,
            right: 12,
            child: Icon(Icons.favorite_border, size: 22, color: Colors.black87),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: GestureDetector(
              onTap: _addTeaToCart,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF006338),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Image.asset('assets/images/shop_icon.png',
                    width: 20, height: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartIconButton extends StatelessWidget {
  final int count;
  final VoidCallback onPressed;

  const _CartIconButton({required this.count, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/shop_icon.png',
              width: 22,
              height: 22,
              color: const Color.fromARGB(175, 0, 0, 0),
            ),
            if (count > 0)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 2),
                  constraints: const BoxConstraints(
                      minWidth: 16, minHeight: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6A00),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count > 99 ? '99+' : count.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
