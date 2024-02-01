import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/main/series_main_bloc.dart';
import 'package:tv_series/presentation/bloc/main/series_main_event.dart';
import 'package:tv_series/presentation/bloc/main/series_main_state.dart';
import 'package:tv_series/presentation/pages/popular_series_page.dart';
import 'package:tv_series/presentation/pages/series_detail_page.dart';
import 'package:tv_series/presentation/pages/top_rated_series_page.dart';

import 'now_playing_series_page.dart';

class TvSeriesPage extends StatefulWidget {
  @override
  _TvSeriesPageState createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<SeriesMainBloc>()
      ..add(const SeriesMainNowPlayingEvent())
      ..add(const SeriesMainPopularEvent())
      ..add(const SeriesMainTopRatedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeriesMainBloc, SeriesMainState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NowPlayingSeriesPage.ROUTE_NAME),
              ),
              StateContent(
                state: state.nowPlayingState,
                builder: (data) {
                  return _SeriesList(data);
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularSeriesPage.ROUTE_NAME),
              ),
              StateContent(
                state: state.popularState,
                builder: (data) {
                  return _SeriesList(data);
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedSeriesPage.ROUTE_NAME),
              ),
              StateContent(
                state: state.topRatedState,
                builder: (data) {
                  return _SeriesList(data);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class _SeriesList extends StatelessWidget {
  final List<TvSeries> seriesList;

  const _SeriesList(this.seriesList);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = seriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.ROUTE_NAME,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: seriesList.length,
      ),
    );
  }
}
