import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/Utility/round_button.dart';
import 'package:flutter_state_techcorner/model/item_card_model.dart';

class DetailWidget extends StatelessWidget {
  final ItemCardModel _itemCardModel;

  DetailWidget(this._itemCardModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          automaticallyImplyLeading: true,
          elevation: 0,
          title: Text('XYZ', style: TextStyle(color: Colors.white)),
          // leading:

          /*  IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
          ),
          */
          actions: <Widget>[
            RoundButton(30, 30, Icons.favorite),
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 300,
                      child: Stack(children: <Widget>[
                        Positioned(
                          top: -300,
                          left: -30,
                          child: Container(
                            height: 550,
                            width: 550,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
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
              ),
              Container(
                height: 100,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) => Container(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        icon: Icon(Icons.opacity),
                      ),
                      decoration: new BoxDecoration(color: Colors.grey),
                    )),
              ),
            ],
          ),
        ));
  }
}
