import 'dart:async';

import 'package:flutter_state_techcorner/blocs/bloc_base.dart';
import 'package:flutter_state_techcorner/model/brand.dart';
import 'package:flutter_state_techcorner/model/brand_states.dart';
import 'package:flutter_state_techcorner/model/filter_event.dart';
import 'package:flutter_state_techcorner/model/shoe.dart';
import 'package:flutter_state_techcorner/model/shoe_states.dart';
import 'package:flutter_state_techcorner/model/shoes_list_states.dart';
import 'package:flutter_state_techcorner/network/shoes_repository.dart';

class ShoesBloc implements BlocBase {
  //Streams
  final _shoesController = StreamController<ShoesListStates>();
  Stream<ShoesListStates> get shoes => _shoesController.stream;

  final _brandsController = StreamController<BrandsStates>();
  Stream<BrandsStates> get brands => _brandsController.stream;

  final _shoeDetailsController = StreamController<ShoeStates>.broadcast();
  Stream<ShoeStates> get shoeDetails => _shoeDetailsController.stream;

  //Sinks
  final _filterController = StreamController<FilterEvent>();
  Sink<FilterEvent> get filterSink => _filterController.sink;

  //TEMP
  List<Shoe> _shoesList = new List();
  List<Brand> _brandsList = new List();

  //Repo
  final _shoesRepository;

  ShoesBloc(this._shoesRepository) {
    _shoesController.add(ShoesListUninitialized());
    _brandsController.add(BrandsUninitialized());
    _shoeDetailsController.add(ShoeUninitialized());
    _filterController.stream.listen(_filterShoes);
  }

  void fetchAll() async {
    try {
      _shoesList = await _shoesRepository.fetchShoes();
      _shoesController.add(ShoesListLoaded(_shoesList));
    } catch (e) {
      _shoesController.add(ShoesListError());
    }

    try {
      _brandsList = await _shoesRepository.fetchBrands();
      _brandsController.add(BrandsLoaded(_brandsList));
    } catch (e) {
      _brandsController.add(BrandsError());
    }
  }

  void fetchShoeDetail(int id) async {
    _shoeDetailsController.add(ShoeUninitialized());
    try {
      Shoe shoe = await _shoesRepository.fetchShoeDetails(id);
      _shoeDetailsController.add(ShoeLoaded(shoe));
    } catch (e) {
      _shoeDetailsController.add(ShoeError());
    }
  }

  void _filterShoes(FilterEvent event) {
    if (event is BrandFilterEvent) {
      if (event.brand != "ALL") {
        List<Shoe> temp =
            _shoesList.where((shoe) => shoe.brand == event.brand).toList();
        _shoesController.add(ShoesListLoaded(temp));
      } else {
        _shoesController.add(ShoesListLoaded(_shoesList));
      }
    } else if (event is StatusFilterEvent) {}
  }

  @override
  void dispose() {
    //Streams
    _shoesController.close();
    _brandsController.close();
    _shoeDetailsController.close();

    //Sink
    _filterController.close();
  }
}
