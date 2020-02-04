import 'package:flutter_state_techcorner/model/brand.dart';
import 'package:flutter_state_techcorner/model/shoe.dart';
import 'package:flutter_state_techcorner/network/shoes_api_provider.dart';

class ShoesRepository {

  final ShoesApiProvider shoesApiProvider;

  ShoesRepository(this.shoesApiProvider);

  Future<List<Shoe>> fetchShoes() => shoesApiProvider.fetchShoes();

  Future<List<Brand>> fetchBrands() => shoesApiProvider.fetchBrands();

  Future<Shoe> fetchShoeDetails(int id) => shoesApiProvider.fetchShoeDetails(id);
}