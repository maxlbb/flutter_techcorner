import 'package:flutter/material.dart';
import '../model/item_cart_model.dart';

class ItemCartWidget extends StatelessWidget {
  final ItemCartModel _itemCartModel;

  ItemCartWidget(this._itemCartModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                width: 96.0,
                height: 92.0,
                margin: EdgeInsets.only(
                    left: 8.0, top: 36.0, right: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 16.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(26.0))),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 20.0, top: 4.0, right: 4.0, bottom: 4.0),
                child: Image.asset(
                  _itemCartModel.image,
                  height: 120,
                  width: 120,
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  left: 8.0, top: 36.0, right: 8.0, bottom: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _itemCartModel.name,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _itemCartModel.price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    children: <Widget>[
                      ButtonTheme(
                        height: 32.0,
                        minWidth: 32.0,
                        child: IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.black,
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          _itemCartModel.quantity.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        child: Ink(
                          child: ButtonTheme(
                          height: 32.0,
                          minWidth: 32.0,
                          child: IconButton(
                            icon: Icon(Icons.remove),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
