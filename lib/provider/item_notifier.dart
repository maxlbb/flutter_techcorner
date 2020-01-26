import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/converter/detail_converter.dart';
import 'package:flutter_state_techcorner/provider/constants.dart';
import 'package:flutter_state_techcorner/service/navigator_service.dart';
import 'package:flutter_state_techcorner/utility/route_constants.dart';
import 'base_notifier.dart';

class ItemNotifier extends BaseNotifier {
  NavigatorService navigatorService;

  ItemNotifier({@required this.navigatorService});

  void onItemPressed(int id) {
    get([Api.PATH_DETAILS + "/$id"], (response) {
      var shoeDetail = convertResponseToDetailShoesItems(response[0].body);
      navigatorService.navigateTo(RouteConstants.details, shoeDetail);
    });
  }
}