import 'package:flutter/material.dart';
import 'package:flutter_state_techcorner/Utility/round_button.dart';
import 'package:flutter_state_techcorner/blocs/bloc_provider.dart';
import 'package:flutter_state_techcorner/blocs/shoes_bloc.dart';
import 'package:flutter_state_techcorner/model/shoe.dart';
import 'package:flutter_state_techcorner/widget/item_detail_card.dart';

class DetailWidget extends StatefulWidget {
  final int _id;

  DetailWidget(this._id);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  final Color backgroundColor = new Color.fromARGB(255, 228, 173, 157);
  final Color backgroundColorTopButton = new Color.fromARGB(255, 219, 174, 163);
  final double marginBorder = 10.0;

  ShoesBloc _shoesBloc;

  @override
  void didChangeDependencies() {
    _shoesBloc = BlocProvider.of<ShoesBloc>(context);
    _shoesBloc.fetchShoeDetail(widget._id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Shoe>(
        stream: _shoesBloc.shoeDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: AppBar(
                  backgroundColor: backgroundColor,
                  automaticallyImplyLeading: true,
                  elevation: 0,
                  title: Text(snapshot.data.title,
                      style: TextStyle(color: Colors.white)),
                  actions: <Widget>[
                    RoundButton(
                        30, 30, Icons.favorite, backgroundColorTopButton),
                  ],
                ),
              ),
              body: Container(
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
                              color: backgroundColor,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 280.0,
                              width: 280.0,
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: 'shoe_image' + snapshot.data.id.toString(),
                                child: Image.asset(snapshot.data.image),
                              ),
                            ),
                          ),
                          Container(
                              height: 100,
                              padding: EdgeInsets.all(10.0),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  ItemDetailCard(
                                    Image.asset(snapshot.data.image),
                                    backgroundColor: Colors.black12,
                                    isVideo: false,
                                  ),
                                  ItemDetailCard(
                                    Image.asset(snapshot.data.image),
                                    backgroundColor: Colors.black12,
                                    isVideo: false,
                                  ),
                                  ItemDetailCard(
                                    Image.asset(snapshot.data.image),
                                    backgroundColor: Colors.black12,
                                    isVideo: false,
                                  ),
                                  ItemDetailCard(
                                    Image.asset(snapshot.data.image),
                                    backgroundColor: Colors.black12,
                                    isVideo: true,
                                  )
                                ],
                              )),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: marginBorder),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: snapshot.data.model,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: marginBorder),
                                  alignment: Alignment.topRight,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 14,
                                        left: 5,
                                        child: Container(
                                          height: 55,
                                          width: 100,
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                            color: new Color.fromARGB(
                                                255, 250, 227, 233),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 25),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: snapshot.data.price
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: marginBorder,
                                right: marginBorder,
                                top: marginBorder),
                            child: Text(snapshot.data.detail),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: marginBorder, top: marginBorder),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'MORE DETAILS',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: 110,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
