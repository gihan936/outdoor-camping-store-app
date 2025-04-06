class Product {
  final String id;
  final String name;
  final String shortDescription;
  final String longDescription;
  final double price;
  final List<String> images;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.price,
    required this.images,
    this.quantity = 1,
  });
}
