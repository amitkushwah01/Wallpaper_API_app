import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/bloc/bloc/wallpaper_bloc.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:wallpaper/pages/ImagePage.dart';

// ignore: must_be_immutable
class Imagewidget extends StatefulWidget {
  @override
  State<Imagewidget> createState() => _ImagewidgetState();
  String? link;
  Imagewidget({this.link});
}

class _ImagewidgetState extends State<Imagewidget> {
  late Wallpaer wallpaper;

  @override
  void initState() {
    widget.link == null
        ? BlocProvider.of<WallpaperBloc>(context).add(TrandingWallaperEvent())
        : BlocProvider.of<WallpaperBloc>(context)
            .add(SearchWallpaperEvent('${widget.link}'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallpaperBloc, WallpaperState>(
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
              itemCount: wallpaper.perPage,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    String link = '${wallpaper.photos![index].src!.portrait!}';
                    context.pushTransparentRoute(ImagePage(link));
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
                        child: CachedNetworkImage(
                          imageUrl:
                              wallpaper.photos![index].src!.portrait == null
                                  ? "assets/images/noimage.png"
                                  : wallpaper.photos![index].src!.portrait!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is WallpaperError) {
          var error = state.errormsg;

          return Center(
            child: Text(
              'something went wrong $error',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          );
        }
        return Container();
      },
    );
  }
}
