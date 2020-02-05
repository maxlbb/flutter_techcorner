import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/blocs/bloc_provider.dart';
import 'package:flutter_state_techcorner/blocs/shoes_bloc.dart';
import 'package:flutter_state_techcorner/model/brand.dart';
import 'package:flutter_state_techcorner/model/filter_status.dart';
import 'package:flutter_state_techcorner/model/shoe.dart';
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
          child: StreamBuilder<List<Brand>>(
              stream: _shoesBloc.brands,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return GestureDetector(
                        child: ItemFilterWidget(
                            snapshot.data[index].brand, selectedBrand == index),
                        onTap: () {
                          _shoesBloc.filterSink.add(snapshot.data[index]);
                          setState(() {
                            selectedBrand = index;
                          });
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("Error!");
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
                child: StreamBuilder<List<Shoe>>(
                    stream: _shoesBloc.shoes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext listContext, int index) {
                              return new ItemCardWidget(snapshot.data[index]);
                            });
                      } else if (snapshot.hasError) {
                        return Text("Error!");
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
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
