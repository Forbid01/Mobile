import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../viewmodels/cart_view_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: CartViewModel.instance,
      builder: (context, _) => _buildScaffold(context),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    final vm = CartViewModel.instance;
    final items = vm.items;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 52,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: const Text(
          "Сагс",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: items.isEmpty
          ? _buildEmptyWithBottom()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                    itemCount: items.length,
                    itemBuilder: (context, i) => _buildCartItem(vm, items[i]),
                  ),
                ),
                _buildBottomBar(vm.total),
              ],
            ),
    );
  }

  Widget _buildEmptyWithBottom() {
    return Column(
      children: [
        const Expanded(
          child: Center(
            child: Text(
              "Сагс хоосон байна",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ),
        ),
        _buildBottomBar(0),
      ],
    );
  }

  String _formatPrice(int price) {
    final s = price.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) {
        buffer.write("'");
      }
      buffer.write(s[i]);
    }
    return buffer.toString();
  }

  Widget _buildCartItem(CartViewModel vm, CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 140,
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) => const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF424242),
                        height: 1.35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 46),
                    child: Text(
                      "${_formatPrice(item.price)}₮",
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _CircleTapButton(
                        onTap: () => vm.decrement(item.id),
                        color: const Color.fromARGB(185, 255, 255, 255),
                        shadowColor: Colors.black.withValues(alpha: 0.06),
                        icon: Icons.remove,
                        iconColor: Colors.black54,
                        iconSize: 18,
                      ),
                      const SizedBox(width: 18),
                      Text(
                        item.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 18),
                      _CircleTapButton(
                        onTap: () => vm.increment(item.id),
                        color: const Color(0xFFFF6A00),
                        shadowColor:
                            const Color(0xFFFF6A00).withValues(alpha: 0.35),
                        icon: Icons.add,
                        iconColor: Colors.white,
                        iconSize: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, right: 10),
                  child: GestureDetector(
                    onTap: () => vm.toggleSelected(item.id),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: item.selected
                          ? Image.asset(
                              'assets/images/checkbox.png',
                              fit: BoxFit.contain,
                              color: Colors.black87,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black87, width: 1.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => vm.remove(item.id),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 4, left: 4, right: 10),
                    child: Image.asset(
                      'assets/images/trash.png',
                      width: 22,
                      height: 22,
                      color: Colors.black87,
                      errorBuilder: (c, e, s) => const Icon(
                          Icons.delete_outline,
                          size: 24,
                          color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(int total) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Бүгд :",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF707070),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: _formatPrice(total),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const WidgetSpan(
                            alignment: PlaceholderAlignment.top,
                            child: Padding(
                              padding: EdgeInsets.only(top: 3, left: 1),
                              child: Text(
                                "₮",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6A00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Үргэлжлүүлэх",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleTapButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final Color shadowColor;
  final IconData icon;
  final Color iconColor;
  final double iconSize;

  const _CircleTapButton({
    required this.onTap,
    required this.color,
    required this.shadowColor,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
