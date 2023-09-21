import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:wallpaper/Widgets/snacbar.dart';

import 'package:wallpaper/bloc/bloc/wallpaper_bloc.dart';

import 'package:wallpaper/wallpaper_repository.dart';

class ImagePage extends StatefulWidget {
  String Imagelink;
  ImagePage(this.Imagelink);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool? status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: DismissiblePage(
        onDismissed: () {
          Navigator.of(context).pop();
        },
        direction: DismissiblePageDismissDirection.multi,
        child: Hero(
          tag: 1,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('${widget.Imagelink}'),
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        status = await WallpaperRepository()
                                            .setWallpaperFromUrl(
                                                widget.Imagelink,
                                                type: 1);

                                        if (status == true) {
                                          Navigator.of(context).pop();

                                          MySnackbar(
                                                  "New wallpaper set on Home Screen!")
                                              .build(context);
                                        } else {
                                          MySnackbar("Something went wrong")
                                              .build(context);
                                        }
                                      },
                                      child: Text(
                                        'Home Screen',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    InkWell(
                                      onTap: () async {
                                        status = await WallpaperRepository()
                                            .setWallpaperFromUrl(
                                                widget.Imagelink,
                                                type: 2);
                                        if (status == true) {
                                          Navigator.of(context).pop();
                                          MySnackbar(
                                                  "New wallpaper set on Lock Screen!")
                                              .build(context);
                                        } else {
                                          MySnackbar("Something went wrong")
                                              .build(context);
                                        }
                                      },
                                      child: Text(
                                        'Lock Screen',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    InkWell(
                                      onTap: () async {
                                        status = await WallpaperRepository()
                                            .setWallpaperFromUrl(
                                          widget.Imagelink,
                                        );
                                        if (status == true) {
                                          Navigator.of(context).pop();
                                          MySnackbar(
                                                  "New wallpaper set on Both Screen!")
                                              .build(context);
                                        } else {
                                          MySnackbar("Something went wrong")
                                              .build(context);
                                        }
                                      },
                                      child: Text(
                                        'Both Screen',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.wallpaper,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {
                        bool status = await WallpaperRepository()
                            .downloadWallpaperFromUrl(widget.Imagelink);
                        if (status) {
                          MySnackbar(
                                  "Thank you for downloading this wallpaper!")
                              .build(context);
                        } else {
                          MySnackbar("Sorry, the wallpaper download failed!")
                              .build(context);
                        }
                      },
                      child: Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<WallpaperBloc>(context)
                            .add(AddFavWallpaperEvent(widget.Imagelink));

                        // showDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return AlertDialog(
                        //       title: Text("Delet Note"),
                        //       content: Text("Do u wanna delete "),
                        //     );
                        //   },
                        // );
                        MySnackbar("Great choice! Added to favorites")
                            .build(context);
                      },
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
