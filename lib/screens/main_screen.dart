import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:randomovie/bloc/movie_bloc.dart';
import 'package:randomovie/model/item.dart';
import 'package:randomovie/model/movie.dart';
import 'package:randomovie/model/movie_response.dart';
import 'package:randomovie/style/theme.dart' as Style;

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
              front: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.grey[400],
                ),
                child: Center(
                  child: Image.asset("assets/img/netflix_logo.png"),
                ),
              ),
              back: StreamBuilder<MovieResponse>(
                stream: movieBloc.subject.stream,
                builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.error != null &&
                        snapshot.data.error.length > 0) {
                      return Center(
                        child: Text(
                          snapshot.data.error,
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return _buildMovieWidget(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error,
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.grey[400],
                      ),
                    );
                  }
                },
              )),
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

  Widget _buildMovieWidget(MovieResponse data) {
    MovieModel movie = data.movie;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.grey[400],
            image: DecorationImage(
                image: NetworkImage(
                  "https://img.reelgood.com/content/movie/" +
                      movie.id +
                      "/poster-780.webp",
                ),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.0)
                  ],
                  stops: [
                    0.0,
                    0.5
                  ])),
        ),
        Positioned(
            top: 10.0,
            right: 10.0,
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.black45),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.imdb,
                    color: Style.Colors.imdbColor,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Text(
                    movie.imdbRate.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
        Positioned(
            bottom: 50.0,
            left: 10.0,
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    movie.overview,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            EvaIcons.clockOutline,
                            color: Colors.white,
                            size: 15.0,
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            movie.duration.toString() + "min",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            EvaIcons.calendarOutline,
                            color: Colors.white,
                            size: 15.0,
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            movie.releaseDate == null
                                ? 0000 - 00 - 00
                                : movie.releaseDate.substring(0, 10),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }
}
