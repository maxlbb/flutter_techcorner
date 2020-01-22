import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  final IconData _icon;
  final String _counter;

  IconBadge(this._icon, this._counter);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Icon(_icon),
        new Positioned(
          right: 0,
          child: new Container(
            padding: EdgeInsets.all(1),
            decoration: new BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: new Text(
              '$_counter',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
