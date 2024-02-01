import 'package:core/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_event.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_state.dart';

import '../widgets/series_card_list.dart';

class TopRatedSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-series';

  @override
  _TopRatedSeriesPageState createState() => _TopRatedSeriesPageState();
}

class _TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<SeriesTopRatedBloc>().add(const SeriesTopRatedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Series'),
      ),
      body: BlocBuilder<SeriesTopRatedBloc, SeriesTopRatedState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StateContent(
              state: state.seriesState,
              builder: (data) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return SeriesCard(data[index]);
                  },
                  itemCount: data.length,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
