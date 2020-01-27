import 'dart:async';

import 'package:flutter_state_techcorner/blocs/bloc_base.dart';
import 'package:flutter_state_techcorner/model/brand.dart';
import 'package:flutter_state_techcorner/model/brand_states.dart';
import 'package:flutter_state_techcorner/model/filter_event.dart';
import 'package:flutter_state_techcorner/model/shoe.dart';
import 'package:flutter_state_techcorner/model/shoes_states.dart';
import 'package:flutter_state_techcorner/network/shoes_repository.dart';

class ShoesBloc implements BlocBase {
  //Streams
  final _shoesController = StreamController<ShoesStates>();
  Stream<ShoesStates> get shoes => _shoesController.stream;

  final _brandsController = StreamController<BrandsStates>();
  Stream<BrandsStates> get brands => _brandsController.stream;

  //Sinks
  final _filterController = StreamController<FilterEvent>();
  Sink<FilterEvent> get filterSink => _filterController.sink;

  //TEMP
  List<Shoe> _shoesList = new List();
  List<Brand> _brandsList = new List();

  //Repo
  final _shoesRepository = ShoesRepository();

  ShoesBloc() {
    _shoesController.add(ShoesUninitialized());
    _brandsController.add(BrandsUninitialized());
    _filterController.stream.listen(_filterShoes);
  }

  void fetchAll() async {
    try {
      _shoesList = await _shoesRepository.fetchShoes();
      _shoesController.add(ShoesLoaded(_shoesList));
    } catch (e) {
      _shoesController.add(ShoesError());
    }

    try {
      _brandsList = await _shoesRepository.fetchBrands();
      _brandsController.add(BrandsLoaded(_brandsList));
    } catch (e) {
      _brandsController.add(BrandsError());
    }
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
