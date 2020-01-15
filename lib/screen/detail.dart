import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/model/item_card_model.dart';

class DetailWidget extends StatelessWidget {
  final ItemCardModel _itemCardModel;

  DetailWidget(this._itemCardModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          /*Hero(
            tag: 'back' + _itemCardModel.id.toString(),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.orange),
            ),
          ),*/
          Container(
            alignment: Alignment.topCenter,
            color: Colors.white,
            child: Container(
              height: 192.0,
              width: 192.0,
              child: Hero(
                transitionOnUserGestures: true,
                tag: 'shoe_image' + _itemCardModel.id.toString(),
                child: Image.asset(_itemCardModel.image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
