import 'package:core/common/constants.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/search/series_search_bloc.dart';
import 'package:tv_series/presentation/bloc/search/series_search_event.dart';
import 'package:tv_series/presentation/bloc/search/series_search_state.dart';
import 'package:tv_series/presentation/widgets/series_card_list.dart';

class SearchSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search/series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SeriesSearchBloc>().add(SeriesSearchEvent(query));
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
            BlocBuilder<SeriesSearchBloc, SeriesSearchState>(
              builder: (context, state) {
                return  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: StateContent(
                          state: state.seriesState,
                          builder: (data) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                final movie = data[index];
                                return SeriesCard(movie);
                              },
                              itemCount: data.length,
                            );
                          },
                      ),
                    ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
