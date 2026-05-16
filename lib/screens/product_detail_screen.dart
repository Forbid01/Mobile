import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String heroTag;
  final String imagePath;
  final String productName;
  final String price;

  const ProductDetailScreen({
    super.key,
    required this.heroTag,
    required this.imagePath,
    required this.productName,
    required this.price,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  final Map<String, bool> _expanded = {
    'detail': false,
    'usage': false,
    'composition': false,
    'warning': false,
  };

  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // ── AppBar + Hero зураг ──
              SliverAppBar(
                expandedHeight: 380,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border,
                        color: Colors.black87, size: 22),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('assets/images/shop_icon.png',
                        width: 22, height: 22, color: Colors.black87),
                    onPressed: () {},
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: const Color(0xFFEFF5F0),
                    padding: const EdgeInsets.only(top: 60),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Hero(
                            tag: widget.heroTag,
                            child: Image.asset(
                              widget.imagePath,
                              fit: BoxFit.contain,
                              height: 300,
                              errorBuilder: (c, e, s) => const Icon(
                                  Icons.image_not_supported,
                                  size: 80,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ── Агуулга ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Нэр
                      Text(
                        widget.productName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      // Ангилал
                      const Text(
                        "гоо сайхан • нүүр арчилгаа",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 140, 0),
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 14),
                      // Үнэ
                      Text(
                        widget.price,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Divider(height: 1, color: Color(0xFFEEEEEE)),

                      // ── Дэлгэрэнгүй хэсгүүд ──
                      _buildSection(
                        key: 'detail',
                        title: 'БҮТЭЭГДЭХҮҮНИЙ ДЭЛГЭРЭНГҮЙ',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            _BulletText("Нүүр болон нүдний будгийг арилгана"),
                            _BulletText(
                                "Арьсыг цэвэрлэж зөөлрүүлэн тайвшруулна"),
                            _BulletText(
                                "Арьсны хамгаалах давхаргыг сэргээнэ"),
                          ],
                        ),
                      ),

                      _buildSection(
                        key: 'usage',
                        title: 'ХЭРЭГЛЭХ ЗААВАР',
                        content: const _NumberedText([
                          "Хөвөнд шингээж арчина.",
                          "Өдөр тутам хэрэглэнэ.",
                          "Дараа нь Avene Халуун раашан хэрэглэвэл тохиромжтой.",
                        ]),
                      ),

                      _buildSection(
                        key: 'composition',
                        title: 'БҮТЭЭГДЭХҮҮНИЙ НАЙРЛАГА',
                        content: const Text(
                          "AVÈNE THERMAL SPRING WATER, MINERAL OIL, CAPRYLIC/CAPRIC TRIGLYCERIDE, CYCLOMETHICONE, GLYCERIN, SUCROSE STEARATE, PEG-12, SUCROSE DISTEARATE, TRIETHANOLAMINE, BATYL ALCOHOL, BISABOLOL, CAPRYLIC/CAPRIC GLYCERIDES, CARBOMER, DEXTRAN SULFATE, DISODIUM EDTA, SODIUM HYALURONATE, TOCOPHERYL.",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              height: 1.6),
                        ),
                      ),

                      _buildSection(
                        key: 'warning',
                        title: 'АНХААРУУЛГА',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            _BulletText(
                                "Ил шархтай болон хэт эмзэг арьстай үед нарийн мэгжлийн эмчээс зөвлөгөө авч хэрэглэнэ үү."),
                            _BulletText(
                                "Бага насны хүүхдийн хүрэх газар байлгах нь эрсдэлтэйг анхаарна уу."),
                            _BulletText(
                                "24°С болон түүнээс доош хэм бүхий харанхуй, нарны гэрэл шууд тусахаргүй газар хадгална."),
                          ],
                        ),
                      ),

                      const Divider(height: 1, color: Color(0xFFEEEEEE)),

                      // ── Ижил төстэй бүтээгдэхүүн ──
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "ИЖИЛ ТӨСТЭЙ БҮТЭЭГДЭХҮҮН",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3),
                            ),
                            Icon(Icons.arrow_forward,
                                size: 18, color: Colors.black87),
                          ],
                        ),
                      ),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          final gap = 12.0;
                          final cardWidth = (constraints.maxWidth - gap) / 2;
                          return SizedBox(
                            height: 250,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemCount: 3,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: gap),
                              itemBuilder: (context, index) => SizedBox(
                                width: cardWidth,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 6),
                                  child: _buildSimilarProductCard(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Floating cart button ──
          Positioned(
            bottom: 24,
            right: 20,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF6A00),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x44FF6A00),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: RotationTransition(
                    turns: _rotationController,
                    child: Image.asset(
                      'assets/images/shop_icon.png',
                      fit: BoxFit.contain,
                      color: Colors.white,
                      errorBuilder: (c, e, s) => const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 24),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String key,
    required String title,
    required Widget content,
  }) {
    final isOpen = _expanded[key] ?? false;
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _expanded[key] = !isOpen),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3),
                ),
                AnimatedRotation(
                  turns: isOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.black54, size: 22),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: content,
          ),
          crossFadeState:
              isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
        const Divider(height: 1, color: Color(0xFFEEEEEE)),
      ],
    );
  }

  Widget _buildSimilarProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 90,
                    child: Image.asset("assets/images/tea.png",
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey)),
                  ),
                ),
                const Spacer(),
                const Text(
                  "Энхжин булцуут цэцгийн цай",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text("12000",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(width: 3),
                    Image.asset("assets/images/Vector.png",
                        height: 11,
                        width: 11,
                        errorBuilder: (c, e, s) =>
                            const Text("₮", style: TextStyle(fontSize: 13))),
                  ],
                ),
                Text("42000₮",
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        decoration: TextDecoration.lineThrough)),
              ],
            ),
          ),
          // ШИНЭ badge
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: const BoxDecoration(
                color: Color(0xFF00E676),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: const Text("ШИНЭ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          // Favorite
          const Positioned(
            top: 8,
            right: 10,
            child: Icon(Icons.favorite_border, size: 20, color: Colors.black54),
          ),
          // Cart button
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                color: Color(0xFF006338),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset('assets/images/shop_icon.png',
                  width: 17, height: 17, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Helper widgets ──

class _BulletText extends StatelessWidget {
  final String text;
  const _BulletText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ",
              style: TextStyle(fontSize: 13, color: Colors.black87)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 13, color: Colors.black87, height: 1.5)),
          ),
        ],
      ),
    );
  }
}

class _NumberedText extends StatelessWidget {
  final List<String> items;
  const _NumberedText(this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        items.length,
        (i) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            "${i + 1}. ${items[i]}",
            style: const TextStyle(
                fontSize: 13, color: Colors.black87, height: 1.5),
          ),
        ),
      ),
    );
  }
}
