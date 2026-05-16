import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  static const _couponColors = [
    Color(0xFFEAE8F5),
    Color(0xFFE8F5EE),
    Color(0xFFF5EDE8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "Захиалга",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              decoration: TextDecoration.lineThrough),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.builder(
              itemCount: 20,
              itemBuilder: (context, i) =>
                  _buildCouponCard(_couponColors[i % _couponColors.length]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => _buildOrderProductCard(context, index),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  Widget _buildCouponCard(Color bgColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 110,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/Subtract.png',
            fit: BoxFit.fill,
            color: bgColor,
            colorBlendMode: BlendMode.srcIn,
          ),
          Row(
            children: [
              SizedBox(
                width: 114,
                child: Center(
                  child: Text(
                    "60%",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.white,
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 60, right: 14, top: 20, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Гэнэтийн урамшуулал",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 0, 0, 0),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "1 өдөр үлдсэн",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black45,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Text(
                                "12000₮",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Ашиглах",
                              style: TextStyle(
                                color: Color(0xFFE85C00),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Color(0xFFE85C00),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderProductCard(BuildContext context, int index) {
    final heroTag = 'product-tea-$index';
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailScreen(
            heroTag: heroTag,
            imagePath: "assets/images/tea.png",
            productName: "Avene мицеллар лосьон",
            price: "12'000₮",
          ),
        ),
      ),
      child: Container(
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
                    child: Hero(
                      tag: heroTag,
                      child: Image.asset("assets/images/tea.png",
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => const Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey)),
                    ),
                  ),
                ),
                const Spacer(),
                const Text("Энхжин булцуут цэцгийн цай",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(
                        text: "12,000",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const WidgetSpan(child: SizedBox(width: 2)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Image.asset("assets/images/Vector.png",
                          height: 12,
                          width: 12,
                          errorBuilder: (c, e, s) => const Text("₮")),
                    ),
                  ]),
                ),
                Text("42,000₮",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        decoration: TextDecoration.lineThrough)),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF006338),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Image.asset('assets/images/shop_icon.png',
                  width: 20, height: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    )); // GestureDetector + Container
  }
}
