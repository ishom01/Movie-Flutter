import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/home_enum.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:flutter/material.dart';

class WatchlistCard extends StatelessWidget {
  final Watchlist watchlist;

  WatchlistCard(this.watchlist);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          if (watchlist.type == DataType.Movie.index) {
            Navigator.pushNamed(
              context,
              MovieDetailPage.ROUTE_NAME,
              arguments: watchlist.id,
            );
          }
          else {
            Navigator.pushNamed(
              context,
              SeriesDetailPage.ROUTE_NAME,
              arguments: watchlist.id,
            );
          }
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      watchlist.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 4),
                    Text(
                      DataType.values[watchlist.type ?? 0].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6
                          .copyWith(color: Colors.yellow, fontSize: 12),
                    ),
                    SizedBox(height: 12),
                    Text(
                      watchlist.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${watchlist.path}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
