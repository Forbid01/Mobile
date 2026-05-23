class CartItem {
  final String id;
  final String name;
  final String imagePath;
  final int price;
  int quantity;
  bool selected;

  CartItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
    this.selected = true,
  });

  int get lineTotal => price * quantity;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imagePath': imagePath,
        'price': price,
        'quantity': quantity,
        'selected': selected,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json['id'] as String,
        name: json['name'] as String,
        imagePath: json['imagePath'] as String,
        price: json['price'] as int,
        quantity: json['quantity'] as int? ?? 1,
        selected: json['selected'] as bool? ?? true,
      );
}
