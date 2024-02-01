import 'package:core/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_event.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_state.dart';

import '../widgets/series_card_list.dart';

class PopularSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-series';

  @override
  _PopularSeriesPageState createState() => _PopularSeriesPageState();
}

class _PopularSeriesPageState extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<SeriesPopularBloc>().add(const SeriesPopularEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Series'),
      ),
      body: BlocBuilder<SeriesPopularBloc, SeriesPopularState>(
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
