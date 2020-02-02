import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/service/api.dart';

abstract class BaseNotifier with ChangeNotifier {
  bool _busy = false;
  bool get isLoading => _busy;

  Api api;

  BaseNotifier(this.api);

  void showLoader({bool show = false}) {
    _busy = show;
    notifyListeners();
  }
}