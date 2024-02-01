import 'package:core/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing/series_now_playing_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing/series_now_playing_event.dart';
import 'package:tv_series/presentation/bloc/now_playing/series_now_playing_state.dart';

import '../widgets/series_card_list.dart';

class NowPlayingSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-series';

  @override
  _NowPlayingSeriesPageState createState() => _NowPlayingSeriesPageState();
}

class _NowPlayingSeriesPageState extends State<NowPlayingSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<SeriesNowPlayingBloc>().add(const SeriesNowPlayingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeriesNowPlayingBloc, SeriesNowPlayingState>(
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
      ),
    );
  }
}
