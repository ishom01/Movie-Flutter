import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';

class SeriesSeasonsList extends StatelessWidget {

  final Map<Season, List<Episode>> seasonMaps;
  final bool isExpanded;

  const SeriesSeasonsList({
    super.key,
    required this.seasonMaps, required this.isExpanded
  });

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: seasonMaps.keys.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal : isExpanded ? 12 : 0),
              height: isExpanded ? 48 : 32,
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabAlignment: TabAlignment.start  ,
                isScrollable: true,
                labelPadding: EdgeInsets.all(8),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: seasonMaps.keys.map((season) {
                  return Tab(
                    child: Text(
                      season.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isExpanded ? 14 : 12
                      ),
                    ),
                  );
                }).toList()
              ),
            ),
            parentContentSeason(context),
          ],
        )
    );
  }
                                                                                                        
  Widget parentContentSeason(BuildContext context) {
    if (isExpanded) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 112,
        child: contentSeasons()
      );
    }
    return contentSeasons();
  }

  Widget contentSeasons() {
    var maxEpisodes = maxEpisodeLength();
    var itemCount = isExpanded ? maxEpisodes
        : maxEpisodes > 3 ? 3 : maxEpisodes;
    return SizedBox(
      height: 91.0 * itemCount,
      child: TabBarView(
        children: seasonMaps.keys.map((season) {
          var episodes = seasonMaps[season] ?? [];
          return ListView.builder(
              itemCount: itemCount,
              physics: isExpanded ? null : NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                try {
                  return EpisodeCard(episodes[index]);
                } catch(e) {
                  return SizedBox();
                }
              }
          );
        }).toList(),
      ),
    );
  }

  int maxEpisodeLength() {
    return seasonMaps.keys.map((key) {
      try {
        return seasonMaps[key]!.length;
      } catch (e) {
        return 0;
      }
    }).toList().reduce((value, element) => element > value ? element : value);
  }
}