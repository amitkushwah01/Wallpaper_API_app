import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/wallpaper_bloc.dart';
import '../model/wallpaper_model.dart';
import 'ImagePage.dart';

class SearchPage extends StatefulWidget {
  String queary;
  SearchPage(this.queary);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WallpaperBloc>(context)
        .add(SearchWallpaperEvent(widget.queary));
  }

  late Wallpaer wallpaper;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          //Custom app bar
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.keyboard_return,
                    size: 30,
                  ),
                ),
                Text(
                  'Seach Wallpaper',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff85C1E9)),
                ),
                Text('')
              ],
            ),
          ),
          //Custom app bar

          //Tabbar

          Expanded(child: BlocBuilder<WallpaperBloc, WallpaperState>(
            builder: (context, state) {
              if (state is WallpaperLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is WallpaperLoaded) {
                wallpaper = state.wallpaper;
                return Padding(
                  padding: EdgeInsets.all(6),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: 40,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          String link =
                              '${wallpaper.photos![index].src!.portrait!}';
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImagePage(link),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hero(
                              tag: '$index',
                              child: Image.network(
                                "${wallpaper.photos![index].src!.portrait!}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          )),

          //Tabbar
        ],
      )),
    );
  }
}
