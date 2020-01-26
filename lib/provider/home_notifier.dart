import 'package:flutter_state_techcorner/converter/home_converter.dart' as homeConverter;
import 'package:flutter_state_techcorner/provider/base_notifier.dart';
import '../model/brand.dart';
import '../model/shoe.dart';
import 'constants.dart';

class HomeNotifier extends BaseNotifier {
  List<Brand> _brands = [];
  List<Brand> get brands => _brands;

  List<Shoe> _shoes = [];
  List<Shoe> get shoes => _shoes;

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

  void selectBrand(int index) {
    _brands = _brands.map((item) {
      var currentIdx = _brands.indexOf(item);
      item.selected = index == currentIdx;
      return item;
    }).toList();

    notifyListeners();
  }
}