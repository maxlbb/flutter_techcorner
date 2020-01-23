import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/Utility/round_button.dart';
import 'package:flutter_state_techcorner/model/item_card_model.dart';
import 'package:flutter_state_techcorner/widget/item_detail_card.dart';

class DetailWidget extends StatelessWidget {
  final ItemCardModel _itemCardModel;

  DetailWidget(this._itemCardModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.red,
            automaticallyImplyLeading: true,
            elevation: 0,
            title: Text('Nike', style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              RoundButton(30, 30, Icons.favorite, Colors.red),
            ],
          ),
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
                        height: 280.0,
                        width: 280.0,
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
                padding: EdgeInsets.all(10.0),
                child: ListView.builder(
                    itemCount: 30,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) => ItemDetailCard(
                        Image.asset(_itemCardModel.image), Colors.black12)),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Air-Max-270',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10.0),
                      alignment: Alignment.topRight,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          children: <TextSpan>[
                            TextSpan(
                                text: '\$150',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
