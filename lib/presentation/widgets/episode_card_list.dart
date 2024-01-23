import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/presentation/widgets/image_handler.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  EpisodeCard(this.episode);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 16
            ),
            height: 88,
            child: ClipRRect(
              child: ImageHandlerWidget(
                path: episode.stillPath,
                width: 120,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kSubtitle.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    episode.runtime != null ? _showDuration(episode.runtime!) : '-',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kSubtitle.copyWith(fontSize: 10, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    episode.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kSubtitle.copyWith(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}