import 'brand.dart';

abstract class BrandsStates {
  const BrandsStates();

  //void get brandsList;
}

class BrandsUninitialized extends BrandsStates {}

class BrandsError extends BrandsStates {}

class BrandsLoaded extends BrandsStates {
  final List<Brand> brands;

  List<Brand> get brandsList => brands;

  BrandsLoaded(this.brands);
}
