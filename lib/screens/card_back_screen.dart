import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:randomovie/bloc/movie_bloc.dart';
import 'package:randomovie/model/movie.dart';
import 'package:randomovie/model/movie_response.dart';
import 'package:randomovie/style/theme.dart' as Style;

class CardBackScreen extends StatefulWidget {
  @override
  _CardBackScreenState createState() => _CardBackScreenState();
}

class _CardBackScreenState extends State<CardBackScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
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