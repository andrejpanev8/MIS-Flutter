class Product {
  int id;
  final String picture;
  final String name;
  final String description;
  final double price;

  Product(
      {required this.id,
      this.picture = "",
      this.name = "",
      this.description = "",
      this.price = 99999.99});

  Product.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        picture = data['picture'],
        name = data['name'],
        description = data['description'],
        price = data['price'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'picture': picture,
        'name': name,
        'description': description,
        'price': price
      };
}
