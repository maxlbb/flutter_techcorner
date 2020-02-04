import 'package:flutter_state_techcorner/model/shoe.dart';

abstract class ShoeStates {
  const ShoeStates();
}

class ShoeUninitialized extends ShoeStates {}

class ShoeError extends ShoeStates {}

class ShoeLoaded extends ShoeStates {
  final Shoe shoe;

  Shoe get shoeDetails => shoe;

  ShoeLoaded(this.shoe);
}
