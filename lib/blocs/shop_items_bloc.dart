import 'dart:async';

import 'package:flutter_state_techcorner/blocs/bloc_base.dart';
import 'package:flutter_state_techcorner/model/brand_filter.dart';
import 'package:flutter_state_techcorner/model/item_filter_model.dart';
import 'package:flutter_state_techcorner/model/status_filter.dart';
import 'package:flutter_state_techcorner/model/item_card_model.dart';

class ShopItemsBloc implements BlocBase {
  final _discoverItemsController = StreamController<List<ItemCardModel>>();
  final _featuredItemsController = StreamController<List<ItemCardModel>>();
  final _brandFilterController = StreamController<List<BrandFilter>>();
  final _statusFilterController = StreamController<List<StatusFilter>>();

  Stream<List<ItemCardModel>> get discoverItemsStream =>
      _discoverItemsController.stream;

  Stream<List<ItemCardModel>> get featuredItemsStream =>
      _featuredItemsController.stream;

  Stream<List<BrandFilter>> get brandFilterStream =>
      _brandFilterController.stream;

  Stream<List<StatusFilter>> get statusFilterStream =>
      _statusFilterController.stream;

  final List<ItemCardModel> _discoverItemsList = new List();
  final List<ItemCardModel> _featuredItemsList = new List();
  final List<BrandFilter> _brandFilterList = new List();
  final List<StatusFilter> _statusFilterList = new List();

  void loadItems() async {
    //TODO implementare servizi!
    //final _discoverItemsList = await servizio!

    _discoverItemsList.add(
        ItemCardModel(0, "Nike", "Air Max 90", 120.0, "nike_shoe.png", false));
    _discoverItemsList.add(
        ItemCardModel(1, "Adidas", "Air  90", 120.0, "nike_shoe.png", false));
    _discoverItemsList.add(ItemCardModel(
        2, "Adidas", "Air Max 90", 120.0, "nike_shoe.png", false));
    _discoverItemsList.add(
        ItemCardModel(3, "Nike", "Air Max 90", 120.0, "nike_shoe.png", false));
    _discoverItemsList.add(ItemCardModel(
        4, "New Balance", "Air Max 90", 120.0, "nike_shoe.png", false));
    _discoverItemsController.sink.add(_discoverItemsList);

    _featuredItemsList.add(
        ItemCardModel(0, "Nike", "Air Max 90", 120.0, "nike_shoe.png", false));
    _featuredItemsList.add(
        ItemCardModel(1, "Nike", "Air  90", 120.0, "nike_shoe.png", false));
    _featuredItemsList.add(
        ItemCardModel(2, "Nike", "Air Max 90", 120.0, "nike_shoe.png", false));
    _featuredItemsList.add(
        ItemCardModel(3, "Nike", "Air Max 90", 120.0, "nike_shoe.png", false));
    _featuredItemsList.add(
        ItemCardModel(4, "Nike", "Air Max 90", 120.0, "nike_shoe.png", false));
    _featuredItemsController.sink.add(_featuredItemsList);

    _brandFilterList.add(BrandFilter(BrandFilter.ALL, true));
    _brandFilterList.add(BrandFilter("Nike", false));
    _brandFilterList.add(BrandFilter("Adidas", false));
    _brandFilterList.add(BrandFilter("Vice", false));
    _brandFilterList.add(BrandFilter("New Balance", false));
    _brandFilterController.sink.add(_brandFilterList);

    _statusFilterList.add(StatusFilter(StatusFilter.UPCOMING, false));
    _statusFilterList.add(StatusFilter(StatusFilter.FEATURED, true));
    _statusFilterList.add(StatusFilter(StatusFilter.NEW, false));
    _statusFilterController.sink.add(_statusFilterList);
  }

  void filterDiscoverItemsByBrand(String brand) {
    _brandFilterList.forEach((filter) => filter.isSelected = false);
    BrandFilter selectedFilter =
        _brandFilterList.firstWhere((filter) => filter.brand == brand);
    if (selectedFilter != null) selectedFilter.isSelected = true;

    _brandFilterController.add(_brandFilterList);

    if (brand != BrandFilter.ALL) {
      List<ItemCardModel> tempList =
      _discoverItemsList.where((item) => item.brand == brand).toList();
      _discoverItemsController.sink.add(tempList);
    } else {
      _discoverItemsController.sink.add(_discoverItemsList);
    }
  }

  void filterDiscoverItemsByStatus(String status) {
    //TODO implement status
    List<ItemCardModel> tempList =
        _discoverItemsList.where((item) => true).toList();
    _discoverItemsController.sink.add(tempList);
  }

  @override
  void dispose() {
    _discoverItemsController.close();
    _featuredItemsController.close();
    _brandFilterController.close();
    _statusFilterController.close();
  }
}
