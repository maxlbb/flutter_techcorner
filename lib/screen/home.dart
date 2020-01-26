import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/provider/home_notifier.dart';
import 'package:provider/provider.dart';
import '../widget/item_card.dart';
import '../widget/item_filter.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      Provider.of<HomeNotifier>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBuildHomeWidget(context);
  }

  _buildBuildHomeWidget(BuildContext context) {
    var shoes = Provider.of<HomeNotifier>(context).shoes;
    var brands = Provider.of<HomeNotifier>(context).brands;

    if(shoes.isEmpty || brands.isEmpty) {
      return Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: <Widget>[
        _buildBrands(),
        _buildItemList(),
      ],
    );
  }

  _buildItemList() {
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

  _buildItems() {
    return Expanded(
      child: Consumer<HomeNotifier>(
        builder: (_, model, __) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.shoes.length,
        itemBuilder: (BuildContext listContext, int index) {
          var shoe = model.shoes[index];
          return ItemCardWidget(shoe);
        },
      ),
      ),
    );
  }

  _buildSideBrand() {
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
              child: ItemFilterWidget("Featured", false),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }

  _buildBrands() {
    return Consumer<HomeNotifier>(
      builder: (_, model, ___) => Container(
        margin: EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
        height: 30.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: model.brands.length,
          itemBuilder: (BuildContext listContext, int index) {
            var item = model.brands[index];

            return GestureDetector(
              child: ItemFilterWidget(item.brand, item.selected), 
              onTap: () {
                model.selectBrand(index);
              }
            );
          },
        ),
      ),
    );
  }
}
