import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wallpaper/pages/search_page.dart';

class SearchWidget extends StatelessWidget {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10)
      ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 300,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: 'Search Wallpaper', border: InputBorder.none),
            ),
          ),
          InkWell(
              onTap: () {
                if (controller.text.toString().isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SearchPage(controller.text.toString());
                    },
                  ));
                } else {}
              },
              child: Icon(Icons.search))
        ],
      ),
    );
  }
}
