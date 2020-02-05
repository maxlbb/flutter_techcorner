import 'dart:async';

import 'package:flutter_state_techcorner/blocs/bloc_base.dart';
import 'package:flutter_state_techcorner/model/brand.dart';
import 'package:flutter_state_techcorner/model/shoe.dart';

class ShoesBloc implements BlocBase {
  //Streams
  final _shoesController = StreamController<List<Shoe>>();
  Stream<List<Shoe>> get shoes => _shoesController.stream;

  final _brandsController = StreamController<List<Brand>>();
  Stream<List<Brand>> get brands => _brandsController.stream;

  final _shoeDetailsController = StreamController<Shoe>.broadcast();
  Stream<Shoe> get shoeDetails => _shoeDetailsController.stream;

  //Sinks
  final _filterController = StreamController<Brand>();
  Sink<Brand> get filterSink => _filterController.sink;

  //TEMP
  List<Shoe> _shoesList = new List();
  List<Brand> _brandsList = new List();

  //Repo
  final _shoesRepository;

  ShoesBloc(this._shoesRepository) {
    _filterController.stream.listen(_filterShoes);
    fetchAll();
  }

  void fetchAll() async {
    try {
      _shoesList = await _shoesRepository.fetchShoes();
      _shoesController.add(_shoesList);
    } catch (e) {
      _shoesController.addError(e);
    }

    try {
      _brandsList = await _shoesRepository.fetchBrands();
      _brandsController.add(_brandsList);
    } catch (e) {
      _brandsController.addError(e);
    }
  }

  void fetchShoeDetail(int id) async {
    try {
      Shoe shoe = await _shoesRepository.fetchShoeDetails(id);
      _shoeDetailsController.add(shoe);
    } catch (e) {
      _shoeDetailsController.addError(e);
    }
  }

  void _filterShoes(Brand filter) {
    if (filter.brand != "ALL") {
      List<Shoe> temp =
          _shoesList.where((shoe) => shoe.brand == filter.brand).toList();
      _shoesController.add(temp);
    } else {
      _shoesController.add(_shoesList);
    }
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
