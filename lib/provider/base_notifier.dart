import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class BaseNotifier with ChangeNotifier {
  bool _busy;
  bool get isLoading => _busy;

  String _url = "https://products-go.herokuapp.com";

  void showLoader({bool show = false}) {
    _busy = show;
    notifyListeners();
  }

  void get(List<String> path, void Function(List<http.Response> response) onDone) async {
    var responses = path.map((single) {
      return http.get(_url + single);
    });

    onDone(await Future.wait(responses));
  }
}