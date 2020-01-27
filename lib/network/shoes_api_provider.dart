import 'dart:convert';

import 'package:flutter_state_techcorner/model/brand.dart';
import 'package:flutter_state_techcorner/model/shoe.dart';
import 'package:http/http.dart' show Client;

class ShoesApiProvider {
  static const baseUrl = 'https://products-go.herokuapp.com/api/v1';
  Client client = Client();

  Future<List<Shoe>> fetchShoes() async {
    final shoesUrl = '$baseUrl/products';
    final shoesResponse = await client.get(shoesUrl);

    if (shoesResponse.statusCode != 200) {
      throw Exception('Error getting shoes');
    } else {
      Iterable shoesJson = jsonDecode(shoesResponse.body)['result']['products'];
      return shoesJson.map((shoe) => new Shoe.fromJson(shoe)).toList();
    }
  }

  Future<List<Brand>> fetchBrands() async {
    final brandUrl = '$baseUrl/brands';
    final brandResponse = await client.get(brandUrl);

    if (brandResponse.statusCode != 200) {
      throw Exception('Error getting brands');
    } else {
      Iterable brandsJson = jsonDecode(brandResponse.body)['result']['brands'];
      return brandsJson.map((brand) => new Brand(brand)).toList();
    }
  }
}
