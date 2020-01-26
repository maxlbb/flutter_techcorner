import 'dart:async';

import 'package:flutter_state_techcorner/blocs/bloc_base.dart';
import 'package:flutter_state_techcorner/model/brand.dart';
import 'package:flutter_state_techcorner/model/brand_states.dart';
import 'package:flutter_state_techcorner/model/filter_event.dart';
import 'package:flutter_state_techcorner/model/shoe.dart';
import 'package:flutter_state_techcorner/model/shoes_states.dart';

class ShoesBloc implements BlocBase {
  //TEMP
  final List<Shoe> _shoesList = new List();
  final List<Brand> _brandsList = new List();

  //Streams
  final _shoesController = StreamController<ShoesStates>();
  Stream<ShoesStates> get shoes => _shoesController.stream;

  final _brandsController = StreamController<BrandsStates>();
  Stream<BrandsStates> get brands => _brandsController.stream;

  //Sinks
  final _filterController = StreamController<FilterEvent>();
  Sink<FilterEvent> get filterSink => _filterController.sink;

  ShoesBloc() {
    _shoesController.add(ShoesUninitialized());
    _brandsController.add(BrandsUninitialized());
    _filterController.stream.listen(_filterShoes);
  }

  void loadItems() async {
    //TODO implementare servizi!
    //final _discoverItemsList = await servizio!

    _brandsList.add(Brand("ALL"));
    _brandsList.add(Brand("Nike"));
    _brandsList.add(Brand("Adidas"));
    _brandsList.add(Brand("Vice"));
    _brandsList.add(Brand("New Balance"));
    _brandsController.add(BrandsLoaded(_brandsList));

    _shoesList.add(Shoe(0, "Nike", "Air Max 90", 120.0, "nike_shoe.png"));
    _shoesList.add(Shoe(1, "Adidas", "Air  90", 120.0, "nike_shoe.png"));
    _shoesList.add(Shoe(2, "Adidas", "Air Max 90", 120.0, "nike_shoe.png"));
    _shoesList.add(Shoe(3, "Nike", "Air Max 90", 120.0, "nike_shoe.png"));
    _shoesList
        .add(Shoe(4, "New Balance", "Air Max 90", 120.0, "nike_shoe.png"));
    _shoesController.add(ShoesLoaded(_shoesList));
  }

  void _filterShoes(FilterEvent event) {
    if (event is BrandFilterEvent) {
      if (event.brand != "ALL") {
        List<Shoe> temp =
            _shoesList.where((shoe) => shoe.brand == event.brand).toList();
        _shoesController.add(ShoesLoaded(temp));
      } else {
        _shoesController.add(ShoesLoaded(_shoesList));
      }
    } else if (event is StatusFilterEvent) {}
  }

  @override
  void dispose() {
    //Streams
    _shoesController.close();
    _brandsController.close();

    //Sink
    _filterController.close();
  }
}
