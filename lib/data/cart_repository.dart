import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../models/cart_item.dart';

class CartRepository {
  static const String _itemsKey = 'cart_items_v1';
  static const String _seededKey = 'cart_seeded_v1';

  final GetStorage _box;

  CartRepository({GetStorage? box}) : _box = box ?? GetStorage();

  List<CartItem> loadItems() {
    final raw = _box.read<String>(_itemsKey);
    if (raw == null || raw.isEmpty) return const [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  void saveItems(List<CartItem> items) {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    _box.write(_itemsKey, encoded);
  }

  bool get hasSeeded => _box.read<bool>(_seededKey) == true;

  void markSeeded() => _box.write(_seededKey, true);
}
