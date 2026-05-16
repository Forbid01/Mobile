import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _tabs = ["Хямдрал", "Онцлох", "Зөвхөн танд"];

  static final _saleAssets = [
    "assets/images/monos.png",
    "assets/images/nailtek.png",
    "assets/images/ymonos.png",
    "assets/images/Hadalabo.png",
  ];

  static const _featuredLabels = ["70%", "50%", "", "45%"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "Мэдэгдэл",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: _buildTabBar(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList((index) => _buildSaleItem(index)),
          _buildList((index) => _buildFeaturedItem(index)),
          _buildList((index) => _buildFeaturedItem(index)),
        ],
      ),
    );
  }

  Widget _buildList(Widget Function(int) itemBuilder) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: 4,
      itemBuilder: (context, index) => itemBuilder(index),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: const Color(0xFFE85C00),
        unselectedLabelColor: Colors.black45,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
        padding: EdgeInsets.zero,
        labelPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
        tabs: _tabs.map((t) => Tab(height: 38, text: t)).toList(),
      ),
    );
  }

  Widget _buildSaleItem(int index) {
    final isRead = index < 2;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 9,
                height: 9,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isRead
                      ? const Color(0xFF4B7FD4)
                      : Colors.transparent,
                  border: isRead
                      ? null
                      : Border.all(
                          color: const Color(0xFF4B7FD4), width: 1.5),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 52,
                  height: 52,
                  color: Colors.white,
                  child: Image.asset(
                    _saleAssets[index % _saleAssets.length],
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      color: Colors.grey.shade100,
                      child: const Icon(Icons.store,
                          size: 24, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Моносын бүтээгдэхүүн хямдрал",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text("10:35",
                          style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(175, 0, 0, 0))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          "Сонгогдсон бүтээгдэхүүнүүд 30% хүртэл хямдарлаа",
                          style: TextStyle(
                              fontSize: 11, color: Colors.black54),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right,
                          color: Color.fromARGB(255, 0, 0, 0), size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedItem(int index) {
    final isRead = index < 2;
    final label = _featuredLabels[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 9,
                height: 9,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isRead
                      ? const Color(0xFF4B7FD4)
                      : Colors.transparent,
                  border: isRead
                      ? null
                      : Border.all(
                          color: const Color(0xFF4B7FD4), width: 1.5),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: [
                  const Color(0xFFE8D5C0),
                  const Color(0xFFCDD5CC),
                  const Color(0xFFE0E0E0),
                  const Color(0xFFD5D0E8),
                ][index % 4],
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: label.isEmpty
                  ? Image.asset(
                      "assets/images/upoint.png",
                      width: 32,
                      height: 32,
                      color: const Color(0xFF4A3000),
                      colorBlendMode: BlendMode.srcIn,
                      errorBuilder: (c, e, s) => const Icon(
                          Icons.shopping_bag_outlined,
                          size: 26,
                          color: Color(0xFF4A3000)),
                    )
                  : Text(
                      label,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black87),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Моносын бүтээгдэхүүн хямдрал",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text("10:35",
                          style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(175, 0, 0, 0))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          "Сонгогдсон бүтээгдэхүүнүүд 30% хүртэл хямдарлаа",
                          style: TextStyle(
                              fontSize: 11, color: Colors.black54),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right,
                          color: Color.fromARGB(255, 0, 0, 0), size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
