import 'package:core/common/constants.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/search/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/search/movie_search_event.dart';
import 'package:movie/presentation/bloc/search/movie_search_state.dart';

import '../widgets/movie_card_list.dart';

class SearchMoviePage extends StatelessWidget {
  static const ROUTE_NAME = '/search/movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<MovieSearchBloc>().add(MovieSearchEvent(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<MovieSearchBloc, MovieSearchState>(
              builder: (context, state) {
                return  Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: StateContent<List<Movie>>(
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
                    ),
                  )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
