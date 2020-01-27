import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/blocs/bloc_provider.dart';
import 'package:flutter_state_techcorner/blocs/shoes_bloc.dart';
import 'package:flutter_state_techcorner/model/brand_states.dart';
import 'package:flutter_state_techcorner/model/filter_event.dart';
import 'package:flutter_state_techcorner/model/filter_status.dart';
import 'package:flutter_state_techcorner/model/shoes_states.dart';
import 'package:flutter_state_techcorner/widget/item_card.dart';
import 'package:flutter_state_techcorner/widget/item_filter.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int selectedBrand = 0;
  int selectedStatus = 1;
  ShoesBloc _shoesBloc;

  @override
  void didChangeDependencies() {
    _shoesBloc = BlocProvider.of<ShoesBloc>(context);
    _shoesBloc.fetchAll();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
          height: 30.0,
          child: StreamBuilder<BrandsStates>(
              stream: _shoesBloc.brands,
              builder: (context, snapshot) {
                if (snapshot.data is BrandsLoaded) {
                  BrandsLoaded brands = snapshot.data as BrandsLoaded;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: brands.brandsList.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return GestureDetector(
                        child: ItemFilterWidget(brands.brandsList[index].brand,
                            selectedBrand == index),
                        onTap: () {
                          _shoesBloc.filterSink.add(
                              BrandFilterEvent(brands.brandsList[index].brand));
                          setState(() {
                            selectedBrand = index;
                          });
                        },
                      );
                    },
                  );
                } else if (snapshot.data is BrandsUninitialized) {
                  return Text("Loading...");
                } else {
                  return Text("Error!");
                }
              }),
        ),
        Container(
          height: 288.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RotatedBox(
                quarterTurns: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: 32.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: StatusFilter.getStatusList.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return GestureDetector(
                        child: ItemFilterWidget(
                            StatusFilter.getStatusList[index].status,
                            selectedStatus == index),
                        onTap: () {
                          _shoesBloc.filterSink.add(StatusFilterEvent(
                              StatusFilter.getStatusList[index].status));
                          setState(() {
                            selectedStatus = index;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<ShoesStates>(
                    stream: _shoesBloc.shoes,
                    builder: (context, snapshot) {
                      if (snapshot.data is ShoesLoaded) {
                        ShoesLoaded shoes = snapshot.data as ShoesLoaded;
                        return new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: shoes.shoesList.length,
                            itemBuilder: (BuildContext listContext, int index) {
                              return new ItemCardWidget(shoes.shoesList[index]);
                            });
                      } else if (snapshot.data is ShoesUninitialized) {
                        return Text("Loading...");
                      } else {
                        return Text("Error!");
                      }
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _shoesBloc.dispose();
    super.dispose();
  }
}
