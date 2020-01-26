import 'package:flutter_state_techcorner/model/shoe.dart';

abstract class ShoesStates {
  const ShoesStates();
}

class ShoesUninitialized extends ShoesStates {}

class ShoesError extends ShoesStates {}

class ShoesLoaded extends ShoesStates {
  final List<Shoe> shoes;

  List<Shoe> get shoesList => shoes;

  ShoesLoaded(this.shoes);
}
