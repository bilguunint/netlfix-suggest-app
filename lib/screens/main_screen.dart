import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:randomovie/bloc/movie_bloc.dart';
import 'package:randomovie/model/item.dart';
import 'package:randomovie/style/theme.dart' as Style;

import 'card_back_screen.dart';
import 'card_front_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool clicked = false;
  ItemModel _selectedGenre;
  ItemModel _selectedScore;
  List<ItemModel> genres;
  List<ItemModel> scores;
  @override
  void initState() {
    scores = [
      ItemModel(title: 'Any Score', value: null),
      ItemModel(title: '5', value: 5),
      ItemModel(title: '6', value: 6),
      ItemModel(title: '7', value: 7),
      ItemModel(title: '8', value: 8),
    ];
    genres = [
      ItemModel(title: 'All Genres', value: null),
      ItemModel(title: 'Action', value: 5),
      ItemModel(title: 'Animation', value: 6),
      ItemModel(title: 'Anime', value: 39),
      ItemModel(title: 'Comedy', value: 9),
      ItemModel(title: 'Drama', value: 3),
      ItemModel(title: 'Horror', value: 19),
    ];
    _selectedGenre = genres[0];
    _selectedScore = scores[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text(
          "What Should I Watch?",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: FlipCard(
              flipOnTouch: false,
              key: cardKey,
              front: CardFront(),
              back: CardBackScreen()),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.0,
        padding: EdgeInsets.all(15.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            clicked
                ? Container()
                : Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Genre",
                            style: TextStyle(
                                color: Style.Colors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5.0),
                            height: 30.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                    color: Style.Colors.mainColor, width: 1.0)),
                            child: Theme(
                              data: ThemeData(canvasColor: Colors.white),
                              child: new DropdownButton<ItemModel>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Style.Colors.mainColor,
                                ),
                                isExpanded: false,
                                underline: Container(),
                                hint: Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Style.Colors.mainColor),
                                ),
                                value: _selectedGenre,
                                onChanged: (ItemModel newValue) {
                                  setState(() {
                                    _selectedGenre = newValue;
                                  });
                                },
                                items: genres.map((ItemModel filter) {
                                  return new DropdownMenuItem<ItemModel>(
                                      value: filter,
                                      child: Row(
                                        children: <Widget>[
                                          new Text(
                                            filter.title,
                                            style: new TextStyle(
                                                color: Style.Colors.mainColor,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ));
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "IMDB Score",
                            style: TextStyle(
                                color: Style.Colors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5.0),
                            height: 30.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                    color: Style.Colors.mainColor, width: 1.0)),
                            child: Theme(
                              data: ThemeData(canvasColor: Colors.white),
                              child: new DropdownButton<ItemModel>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Style.Colors.mainColor,
                                ),
                                isExpanded: false,
                                underline: Container(),
                                hint: Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Style.Colors.mainColor),
                                ),
                                value: _selectedScore,
                                onChanged: (ItemModel newValue) {
                                  setState(() {
                                    _selectedScore = newValue;
                                  });
                                },
                                items: scores.map((ItemModel filter) {
                                  return new DropdownMenuItem<ItemModel>(
                                      value: filter,
                                      child: Row(
                                        children: <Widget>[
                                          new Text(
                                            filter.title,
                                            style: new TextStyle(
                                                color: Style.Colors.mainColor,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ));
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            clicked
                ? Container(
                    height: 40.0,
                    child: RaisedButton(
                        color: Style.Colors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        onPressed: () {
                          setState(() {
                            clicked = false;
                          });
                          movieBloc..drainStream();
                          cardKey.currentState.toggleCard();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(EvaIcons.arrowBackOutline,
                                color: Colors.white),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("Back",
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        )),
                  )
                : Container(
                    height: 40.0,
                    child: RaisedButton(
                        color: Style.Colors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        onPressed: () {
                          movieBloc
                            ..getMovie(
                                _selectedGenre.value, _selectedScore.value);
                          setState(() {
                            clicked = true;
                          });
                          cardKey.currentState.toggleCard();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(EvaIcons.search, color: Colors.white),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("Suggest",
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        )),
                  )
          ],
        ),
      ),
    );
  }

  
}
