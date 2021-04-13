import 'package:flutter/material.dart';
import 'package:jb8http/pages/movie_detail.dart';
import 'package:jb8http/service/http_service.dart';


class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String imgPath = 'https://image.tmdb.org/t/p/w500/';
  int moviesCount;
  List movies;
  HttpService service;

  Future initialize() async {
    movies = [];
    movies = await service.getPopularMovies();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String path;
return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
            itemBuilder: (context, int position) {
              return Card(
                color: Colors.red,
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(imgPath + movies[position].posterPath),
                  ),
                  title: Text(movies[position].title),
                  subtitle: Text(
                      'Rating = ' + movies[position].voteAverage.toString()),
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (_) => MovieDetail(movies[position]));
                    Navigator.push(context, route);
                  },
                ),
              );
            }),
      ),
    );
  }
}