import 'package:flutter/material.dart';
import 'package:wallpaper/Widgets/Imagewidget.dart';
import 'package:wallpaper/Widgets/SearchWidget.dart';
import 'package:wallpaper/pages/favoritePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
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
                    Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    Text(
                      'Wallpaper App',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Favorite()));
                      },
                      child: Icon(
                        Icons.favorite,
                        size: 30,
                        color: Color(0xffE74C3C),
                      ),
                    )
                  ],
                ),
              ),
              //Custom app bar

              //Searchbar
              SearchWidget(),
              //Searchbar

              //Tabbar
              TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  indicator: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 2))),
                  tabs: [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'Animals',
                    ),
                    Tab(
                      text: 'Nature',
                    ),
                    Tab(
                      text: 'Space',
                    ),
                    Tab(
                      text: 'Vintage',
                    ),
                    Tab(
                      text: 'Technology',
                    )
                  ]),
              Flexible(
                  child: Flexible(
                      flex: 1,
                      child: TabBarView(children: [
                        Imagewidget(),
                        Imagewidget(link: 'Animals'),
                        Imagewidget(
                          link: 'Nature',
                        ),
                        Imagewidget(link: 'Space'),
                        Imagewidget(
                          link: 'Vintage',
                        ),
                        Imagewidget(
                          link: 'Technology',
                        ),
                      ])))
              //Tabbar
            ],
          )),
        ));
  }
}
