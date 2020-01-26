import 'package:flutter_state_techcorner/model/shoe.dart';

class ShoeDetail extends Shoe {
  String description;
  String title;

  ShoeDetail(id, brand, model, price, image, {this.title, this.description}) : super(id, brand, model, price, image);
}