import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;

  RoundButton(this.width, this.height, this.icon);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildRoundButton(this.width, this.height, icon);
  }

  Padding buildRoundButton(double width, double height, IconData icon) {
    return Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
            width: width,
            height: height,
            child: IconButton(
              padding: EdgeInsets.only(right: 0.0),
              color: Colors.black,
              icon: Icon(icon),
              onPressed: () {},
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            )));
  }
}
