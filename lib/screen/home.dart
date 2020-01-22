import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/blocs/bloc_provider.dart';
import 'package:flutter_state_techcorner/blocs/shop_items_bloc.dart';
import 'package:flutter_state_techcorner/model/brand_filter.dart';
import 'package:flutter_state_techcorner/model/status_filter.dart';
import 'package:flutter_state_techcorner/model/item_card_model.dart';
import 'package:flutter_state_techcorner/widget/item_card.dart';
import 'package:flutter_state_techcorner/widget/item_filter.dart';
import 'package:flutter_state_techcorner/widget/item_cart.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopItemsBloc shopItemsBloc = BlocProvider.of<ShopItemsBloc>(context);
    shopItemsBloc.loadItems();

    return Column(
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
          height: 30.0,
          child: StreamBuilder<List<BrandFilter>>(
              stream: shopItemsBloc.brandFilterStream,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return GestureDetector(
                        child: ItemFilterWidget(snapshot.data[index].brand,
                            snapshot.data[index].isSelected),
                        onTap: () {
                          shopItemsBloc.filterDiscoverItemsByBrand(
                              snapshot.data[index].brand);
                        },
                      );
                    },
                  );
                } else {
                  return Text("Loading...");
                }
              }),
        ),
        Container(
          height: 288.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StreamBuilder<List<StatusFilter>>(
                  stream: shopItemsBloc.statusFilterStream,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return RotatedBox(
                        quarterTurns: 1,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          height: 32.0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext listContext, int index) {
                              return GestureDetector(
                                child: ItemFilterWidget(
                                    snapshot.data[index].status,
                                    snapshot.data[index].isSelected),
                                onTap: () {
                                  shopItemsBloc.filterDiscoverItemsByStatus(
                                      snapshot.data[index].status);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Text("Loading...");
                    }
                  }),
              Expanded(
                child: StreamBuilder<List<ItemCardModel>>(
                    stream: shopItemsBloc.discoverItemsStream,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext listContext, int index) {
                              return new ItemCardWidget(snapshot.data[index]);
                            });
                      } else {
                        return Text("Loading...");
                      }
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
