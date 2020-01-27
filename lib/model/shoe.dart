class Shoe {
  final int id;
  final String brand;
  final String model;
  final double price;
  final String image;
  final String status;

  Shoe({this.id, this.brand, this.model, this.price, this.image, this.status});

  Shoe.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        brand = json['brand'],
        model = json['model'],
        price = json['price'],
        image = "",//json['image'] as String,
        status = "FEATURED"; //json['status'] as String
}
