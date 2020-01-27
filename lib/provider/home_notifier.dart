import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/converter/detail_converter.dart';
import 'package:flutter_state_techcorner/converter/home_converter.dart' as homeConverter;
import 'package:flutter_state_techcorner/provider/base_notifier.dart';
import 'package:flutter_state_techcorner/service/navigator_service.dart';
import 'package:flutter_state_techcorner/utility/route_constants.dart';
import '../model/brand.dart';
import '../model/shoe.dart';
import 'constants.dart';

class HomeNotifier extends BaseNotifier {
  NavigatorService navigatorService;

  HomeNotifier({@required this.navigatorService});

  List<Brand> _brands = [];
  List<Brand> get brands => _brands;

  List<Shoe> _shoes = [];
  List<Shoe> _filteredShoes = [];
  List<Shoe> get shoes => hasFilter() == null ? _shoes : _filteredShoes;

  void init() {
    showLoader(show: true);

    get([Api.PATH_PRODUCTS, Api.PATH_BRANDS], (responses) {
      var shoes = homeConverter.convertResponseToShoesItems(responses[0].body);
      var brands = homeConverter.convertResponseToBrandItems(responses[1].body);
      _shoes = shoes;
      _brands = brands;
      notifyListeners();
      showLoader(show: false);
    });
  }

  void onItemPressed(int id) {
    showLoader(show: true);

    get([Api.PATH_DETAILS + "/$id"], (response) {
      showLoader(show: false);

      if(response[0].statusCode == 200) {
        var shoeDetail = convertResponseToDetailShoesItems(response[0].body);
        navigatorService.navigateTo(RouteConstants.details, shoeDetail);
      }
    });
  }

  void selectBrand(int index) {
    _brands = _brands.map((item) {
      var currentIdx = _brands.indexOf(item);
      item.selected =  !item.selected && index == currentIdx;
      return item;
    }).toList();

    var filter = hasFilter();

    if(filter != null) {
      _filteredShoes = _shoes.where((it) => it.brand == filter.brand).toList();
    }

    notifyListeners();
  }

  Brand hasFilter() => brands.firstWhere((it) => it.selected, orElse: () => null);
}