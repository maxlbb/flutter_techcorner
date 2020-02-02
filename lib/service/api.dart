import 'package:flutter_state_techcorner/model/brand.dart';
import 'package:flutter_state_techcorner/model/shoe.dart';
import 'package:flutter_state_techcorner/model/shoe_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_state_techcorner/converter/home_converter.dart' as homeConverter;
import 'package:flutter_state_techcorner/converter/detail_converter.dart';

class Api {
  String _url = "https://products-go.herokuapp.com";

  static const String PATH_PRODUCTS = "/api/v1/products";
  static const String PATH_BRANDS = "/api/v1/brands";
  static const String PATH_DETAILS = "/api/v1/details";

  void get(List<String> path, void Function(List<http.Response> response) onDone) async {
    var responses = path.map((single) {
      return http.get(_url + single);
    });

    onDone(await Future.wait(responses));
  }

  void getProductsAndBrands(void Function(List<Shoe> shoes, List<Brand> brands) onDone) {
    get([PATH_PRODUCTS, PATH_BRANDS], (responses) {
      var shoes = homeConverter.convertResponseToShoesItems(responses[0].body);
      var brands = homeConverter.convertResponseToBrandItems(responses[1].body);
      onDone(shoes, brands);
    });
  }

  void getDetails(int id, void Function(ShoeDetail) onDone) {
    get([Api.PATH_DETAILS + "/$id"], (response) {
      if(response[0].statusCode == 200) {
        var shoeDetail = convertResponseToDetailShoesItems(response[0].body);
        onDone(shoeDetail);
      }
    });
  }
}