import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_event.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_state.dart';

import '../widgets/series_season_list.dart';

class SeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/series/detail';

  final int id;
  SeriesDetailPage({required this.id});

  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<SeriesDetailBloc>()
      ..add(FetchSeriesDetailEvent(widget.id))
      ..add(FetchRecommendationSeriesDetailEvent(widget.id))
      ..add(FetchEpisodeEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SeriesDetailBloc, SeriesDetailState>
          (builder: (context, state) {
            return StateContent<TvSeriesDetail>(
              state: state.detailState,
              builder: (data) {
                return _DetailContent(
                  data,
                  state.recommendationState,
                  state.seasonState,
                  false,
                  state.isFavorite,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  final TvSeriesDetail series;
  final UiState<List<TvSeries>> recommendationsState;
  final UiState<Map<Season, List<Episode>>> seasonMapState;
  final bool isExpandedEpisode;
  final bool isFavorite;

  const _DetailContent(
      this.series,
      this.recommendationsState,
      this.seasonMapState,
      this.isExpandedEpisode,
      this.isFavorite
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              series.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                context.read<SeriesDetailBloc>().add(
                                    ChangeWatchlistDetailEvent(
                                        !isFavorite,
                                        series
                                    ));

                                String message = !isFavorite
                                    ? 'Add watchlist success'
                                    : 'Removed from Watchlist';

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isFavorite
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(series.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: series.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${series.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              series.overview,
                            ),
                            const SizedBox(height: 16),
                            StateContent(
                              state: seasonMapState,
                              builder: (data) {
                                return Column(
                                  children: [
                                    SeriesSeasonsList(
                                      seasonMaps: data,
                                      isExpanded: false,
                                    ),
                                    const SizedBox(height: 16),
                                    TextButton(
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all(Colors.yellow)
                                      ),
                                      onPressed:() {
                                        showModalBottomSheet<void>(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return Padding(
                                                padding: const EdgeInsets.all(16),
                                                child: SeriesSeasonsList(
                                                  seasonMaps: data,
                                                  isExpanded: true,
                                                ),
                                              );
                                            }
                                        );
                                      },
                                      child: const Text(
                                        "Show More",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                );
                              },
                            ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            StateContent(
                              state: recommendationsState,
                              builder: (data) {
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final series = data[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              SeriesDetailPage.ROUTE_NAME,
                                              arguments: series.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              'https://image.tmdb.org/t/p/w500${series.posterPath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                    child:
                                                    CircularProgressIndicator(),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: data.length,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
