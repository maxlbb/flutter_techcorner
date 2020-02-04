import 'package:flutter_state_techcorner/model/shoe.dart';

abstract class ShoesListStates {
  const ShoesListStates();
}

class ShoesListUninitialized extends ShoesListStates {}

class ShoesListError extends ShoesListStates {}

class ShoesListLoaded extends ShoesListStates {
  final List<Shoe> shoes;

  List<Shoe> get shoesList => shoes;

  ShoesListLoaded(this.shoes);
}
