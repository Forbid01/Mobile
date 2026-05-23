import 'package:flutter/foundation.dart';

import '../data/cart_repository.dart';
import '../models/cart_item.dart';

class CartViewModel extends ChangeNotifier {
  final CartRepository _repository;
  final List<CartItem> _items = [];

  static final CartViewModel instance =
      CartViewModel._internal(CartRepository());

  CartViewModel._internal(this._repository) {
    _initialize();
  }

  @visibleForTesting
  CartViewModel.forTest(this._repository) {
    _initialize();
  }

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get distinctCount => _items.length;

  int get totalQuantity =>
      _items.fold<int>(0, (sum, item) => sum + item.quantity);

  int get total => _items
      .where((item) => item.selected)
      .fold<int>(0, (sum, item) => sum + item.lineTotal);

  void _initialize() {
    final loaded = _repository.loadItems();
    if (loaded.isNotEmpty) {
      _items.addAll(loaded);
      return;
    }
    if (!_repository.hasSeeded) {
      _items.addAll(_demoItems());
      _repository.markSeeded();
      _persist();
    }
  }

  List<CartItem> _demoItems() => [
        CartItem(
          id: 'lotion-demo-1',
          name: 'Дыши амьсгал чөлөөлөгч наалт 50ММ*60ММ №5',
          imagePath: 'assets/images/Lotion.png',
          price: 12000,
          quantity: 8,
        ),
        CartItem(
          id: 'lotion-demo-2',
          name: 'Дыши амьсгал чөлөөлөгч наалт 50ММ*60ММ №5',
          imagePath: 'assets/images/Lotion.png',
          price: 12000,
          quantity: 8,
        ),
      ];

  void _persist() => _repository.saveItems(_items);

  void addItem({
    required String id,
    required String name,
    required String imagePath,
    required int price,
  }) {
    final existingIndex = _items.indexWhere((item) => item.id == id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(
        id: id,
        name: name,
        imagePath: imagePath,
        price: price,
      ));
    }
    _persist();
    notifyListeners();
  }

  void increment(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index < 0) return;
    _items[index].quantity++;
    _persist();
    notifyListeners();
  }

  void decrement(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index < 0) return;
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
      _persist();
      notifyListeners();
    }
  }

  void remove(String id) {
    final removed = _items.length;
    _items.removeWhere((item) => item.id == id);
    if (_items.length == removed) return;
    _persist();
    notifyListeners();
  }

  void toggleSelected(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index < 0) return;
    _items[index].selected = !_items[index].selected;
    _persist();
    notifyListeners();
  }

  void clear() {
    if (_items.isEmpty) return;
    _items.clear();
    _persist();
    notifyListeners();
  }
}
