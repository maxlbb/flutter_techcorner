import 'package:flutter/material.dart';

class ItemDetailCard extends StatelessWidget {
  final Image image;
  final Color backgroundColor;

  ItemDetailCard(this.image, this.backgroundColor);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ItemDetail(image, backgroundColor);
  }

  Padding ItemDetail(Image image, Color backgroundColor) {
    return Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
          width: 100,
          height: 50,
          child: IconButton(
            icon: image,
          ),
          decoration: new BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ));
  }
}
