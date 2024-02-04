import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_state.dart';

import '../bloc/popular/movie_popular_event.dart';
import '../widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MoviePopularBloc>().add(const MoviePopularEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          builder: (context, state) {
            return StateContent<List<Movie>>(
              state: state.movieState,
              builder: (data) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = data[index];
                    return MovieCard(movie);
                  },
                  itemCount: data.length,
                );
              }
            );
          },
        ),
      ),
    );
  }
}
