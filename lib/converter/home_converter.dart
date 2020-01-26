import 'dart:convert';

import 'package:flutter_state_techcorner/model/brand.dart';
import 'package:flutter_state_techcorner/model/shoe.dart';

List<Shoe> convertResponseToShoesItems(String body) {
  var decodedBody = jsonDecode(body);
  var list = decodedBody['result']['products'].map((shoe) {
    return Shoe(shoe['id'], shoe['brand'], shoe['model'], shoe['price'], "nike_shoe.png",);
  });
  return list.toList().cast<Shoe>();
}

List<Brand> convertResponseToBrandItems(String body) {
  var decodedBody = jsonDecode(body);
  var list = decodedBody['result']['brands'].map((name) {
    return Brand(brand: name, selected: false);
  });
  return list.toList().cast<Brand>();
}