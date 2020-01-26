import 'package:flutter/material.dart';
import '../model/shoe.dart';
import '../widget/item_card.dart';
import '../widget/item_filter.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int selectedBrand = 0;
  int selectedStatus = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildBrands(),
        _buildItemList(),
      ],
    );
  }

  Container _buildItemList() {
    return Container(
        height: 288.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildSideBrand(),
            _buildItems()
          ],
        ),
      );
  }

  Expanded _buildItems() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (BuildContext listContext, int index) {
          return ItemCardWidget(Shoe(
              id: 0,
              brand: "Brand",
              image: "",
              model: "Nike",
              price: 200));
        },
      ),
    );
  }

  RotatedBox _buildSideBrand() {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 32.0,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (BuildContext listContext, int index) {
            return GestureDetector(
              child: ItemFilterWidget("brand", false),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }

  Container _buildBrands() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
      height: 30.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext listContext, int index) {
          return GestureDetector(
              child: ItemFilterWidget("Brand", true), onTap: () {});
        },
      ),
    );
  }
}
