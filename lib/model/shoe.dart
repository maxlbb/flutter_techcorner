class Shoe {
  final int id;
  final String brand;
  final String model;
  final double price;
  final String image;
  final String status;
  final String title;
  final String detail;

  Shoe({this.id, this.brand, this.model, this.price, this.image, this.status, this.title, this.detail});

  Shoe.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        brand = json['brand'],
        model = json['model'],
        price = json['price'],
        title = json['title'] ?? "",
        detail = json['detail'] ?? "",
        image = "",//json['image'] as String,
        status = "FEATURED"; //json['status'] as String
}
