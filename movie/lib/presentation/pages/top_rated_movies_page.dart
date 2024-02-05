import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_event.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_state.dart';

import '../widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieTopRatedBloc>().add(const MovieTopRatedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
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
