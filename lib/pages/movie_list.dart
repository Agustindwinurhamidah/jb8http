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
      body: GridView.builder(
         
          itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
          
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            
          ),
          itemBuilder: (context, int position) {
            return GridTile(
              child: InkResponse(
                enableFeedback: true,
                child: Image.network(
                  imgPath + movies[position].posterPath,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(movies[position]));
                  Navigator.push(context, route);
                },
              ),
            );
          }),
    );
  }
}