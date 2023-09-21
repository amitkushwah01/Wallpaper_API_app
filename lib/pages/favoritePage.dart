import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/bloc/bloc/wallpaper_bloc.dart';
import 'package:wallpaper/db_helper.dart';
import 'package:wallpaper/pages/ImagePage.dart';
import '../Widgets/Imagewidget.dart';
import '../Widgets/SearchWidget.dart';

class Favorite extends StatefulWidget {
  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<Map<String, dynamic>> favWallpaper = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WallpaperBloc>(context).add(GetFavWallpaperEvent());
  }

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
                  'Favourite Wallpaer',
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
              if (state is FavWallpaperLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is FavWallpaperLoaded) {
                favWallpaper = state.favwallpaper;
                return favWallpaper.isEmpty == true
                    ? Center(child: Text("Your Favourite List is Empty"))
                    : Padding(
                        padding: EdgeInsets.all(6),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: favWallpaper.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                String link =
                                    '${favWallpaper[index][Dbhelper().favWallpaperUrl]}';
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ImagePage(link);
                                  },
                                ));
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Delet Note"),
                                      content: Text("Do u wanna delete "),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              BlocProvider.of<WallpaperBloc>(
                                                      context)
                                                  .add(DeleteFavWallpaperEvent(
                                                      favWallpaper[index][
                                                          Dbhelper()
                                                              .favWallpaperId]));
                                              Navigator.pop(context);
                                            },
                                            child: Text("Delete")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancle"))
                                      ],
                                    );
                                  },
                                );
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
                                      "${favWallpaper[index][Dbhelper().favWallpaperUrl]}",
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
