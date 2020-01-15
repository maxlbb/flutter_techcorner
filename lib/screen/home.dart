import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/model/item_card_model.dart';
import 'package:flutter_state_techcorner/model/item_cart_model.dart';
import 'package:flutter_state_techcorner/widget/item_card.dart';
import 'package:flutter_state_techcorner/widget/item_filter.dart';
import 'package:flutter_state_techcorner/widget/item_cart.dart';

class HomeWidget extends StatelessWidget {
  final ItemCartModel _itemCartModel =
      ItemCartModel("Nike air max", 120.0, 'nike_shoe.png', 3);

  final ItemCardModel _itemCardModel0 = ItemCardModel(0, "Nike", "Air Max 90", 120.0, "nike_shoe.png", false);
  final ItemCardModel _itemCardModel1= ItemCardModel(1, "Nike", "Air  90", 120.0, "nike_shoe.png", false);
  final ItemCardModel _itemCardModel2 = ItemCardModel(2, "Nike", "Air Max 90", 120.0, "nike_shoe.png", false);
  final ItemCardModel _itemCardModel3 = ItemCardModel(3, "Nike", "Air Max 90", 120.0, "nike_shoe.png", false);
  final ItemCardModel _itemCardModel4 = ItemCardModel(4, "Nike", "Air Max 90", 120.0, "nike_shoe.png", false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
          height: 30.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ItemFilterWidget(true, 'Nike'),
              ItemFilterWidget(false, 'Adidas'),
              ItemFilterWidget(false, 'Reebok'),
              ItemFilterWidget(false, 'Vice'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          height: 288.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ItemCardWidget(_itemCardModel1),
              ItemCardWidget(_itemCardModel2),
              ItemCardWidget(_itemCardModel3),
              ItemCardWidget(_itemCardModel4),
              ItemCardWidget(_itemCardModel0),
            ],
          ),
        ),
      ],
    );
  }
}
