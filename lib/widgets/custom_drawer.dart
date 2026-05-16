import 'package:flutter/material.dart';
import 'dart:ui';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.85,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildDrawerHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                children: [
                  _menuItem(
                      const Icon(Icons.sell_outlined, color: Colors.black87),
                      "Хямдрал харах"),
                  _menuItem(
                      const Icon(Icons.search, color: Colors.black87),
                      "Брэндээр хайх"),
                  _menuItem(
                      const Icon(Icons.grid_view_outlined,
                          color: Colors.black87),
                      "Ангиллаар хайх"),
                  const SizedBox(height: 10),
                  _menuItem(
                      Image.asset("assets/images/box.png",
                          fit: BoxFit.contain),
                      "Миний хаягууд"),
                  _menuItem(
                      Image.asset("assets/images/Car.png",
                          fit: BoxFit.contain),
                      "Захиалгын түүх"),
                  _menuItem(
                      Image.asset("assets/images/upoint.png",
                          fit: BoxFit.contain),
                      "uPoint"),
                  _menuItem(
                      const Icon(Icons.description_outlined,
                          color: Colors.black87),
                      "Жорын жагсаалт"),
                  _menuItem(
                      const Icon(Icons.history, color: Colors.black87),
                      "Миний сүүлд үзсэн"),
                  const SizedBox(height: 10),
                  _menuItem(
                      const Icon(Icons.info_outline, color: Colors.black87),
                      "eMonos тухай"),
                  _menuItem(
                      const Icon(Icons.star_outline, color: Colors.black87),
                      "Апп үнэлэх"),
                  _menuItem(
                      const Icon(Icons.share_outlined, color: Colors.black87),
                      "Апп хуваалцах"),
                  _menuItem(
                      const Icon(Icons.help_outline, color: Colors.black87),
                      "FAQ"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return SizedBox(
      height: 290,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 220,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        "assets/images/human.png",
                        fit: BoxFit.cover,
                        alignment: const Alignment(-0.5, 0),
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: const Color(0xFFE67E22)),
                      ),
                    ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                            color: Colors.white.withValues(alpha: 0.1)),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE67E22),
                                  shape: BoxShape.circle,
                                ),
                                child: const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/human.png"),
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.white),
                                  ),
                                  child: const Icon(Icons.edit_outlined,
                                      size: 14, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Буяндэлгэр Батбаяр",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _floatingItem(
                      Image.asset("assets/images/mongol.png",
                          width: 18,
                          height: 18,
                          filterQuality: FilterQuality.high),
                      "Монгол"),
                  _floatingItem(
                      Image.asset("assets/images/mongolia.png",
                          width: 18,
                          height: 18,
                          filterQuality: FilterQuality.high),
                      "Төгрөг"),
                  _floatingItem(
                      Image.asset("assets/images/useg.png",
                          width: 18,
                          height: 18,
                          filterQuality: FilterQuality.high),
                      "Үсэг"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingItem(Widget iconWidget, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(child: iconWidget),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(
                fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _menuItem(Widget iconWidget, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 2, bottom: 2),
      child: ListTile(
        leading: SizedBox(
            width: 24, height: 24, child: Center(child: iconWidget)),
        title: Text(title,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500)),
        onTap: () {},
        dense: true,
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(vertical: -3),
      ),
    );
  }
}
