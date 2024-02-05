import 'package:core/common/home_enum.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/movie_page.dart';
import 'package:movie/presentation/pages/search_movie_page.dart';
import 'package:tv_series/presentation/pages/search_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _selectedHomeTypePage = DataType.Movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              selectedColor: Colors.yellow,
              selected: _selectedHomeTypePage == DataType.Movie,
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                setState(() {
                  _selectedHomeTypePage = DataType.Movie;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              selectedColor: Colors.yellow,
              selected: _selectedHomeTypePage == DataType.TvSeries,
              leading: Icon(Icons.local_movies),
              title: Text('Tv Series'),
              onTap: () {
                setState(() {
                  _selectedHomeTypePage = DataType.TvSeries;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: _buildAppbar(),
        actions: [
          IconButton(
            onPressed: () {
              if (_selectedHomeTypePage == DataType.Movie) {
                Navigator.pushNamed(context, SearchMoviePage.ROUTE_NAME);
              } else {
                Navigator.pushNamed(context, SearchSeriesPage.ROUTE_NAME);
              }
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildSelectedPage(),
      ),
    );
  }

  Widget _buildAppbar() {
    if (_selectedHomeTypePage == DataType.TvSeries)
      return Text('Tv Series');
    else
      return Text('Movies');
  }

  Widget _buildSelectedPage() {
    if (_selectedHomeTypePage == DataType.TvSeries)
      return TvSeriesPage();
    else
      return MoviePage();
  }
}
