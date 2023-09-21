import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:wallpaper/api_helper.dart';

import 'package:wallpaper/model/wallpaper_model.dart';

import 'package:http/http.dart' as httpClient;

class WallpaperRepository {
  Future<Wallpaer> getWallpaper(
    String mQuery,
  ) async {
    var mUrl = "search?query=$mQuery&per_page=45}";
    try {
      var data = await Apihelper().getApi(mUrl, header: {
        'Authorization':
            'bQ5T0u3fMl4xx3vj65Ql0YPNWlBWFyI9RT2RHS5CqybR0Qe7ZXxYsFCN'
      });

      return Wallpaer.fromJson(data);
    } catch (e) {
      return Wallpaer();
    }
  }

//tranding wallpaper
  Future<Wallpaer> gettrandingwallpaper() async {
    var mUrl = "curated?per_page=45";
    try {
      var data = await Apihelper().getApi(mUrl, header: {
        'Authorization':
            'bQ5T0u3fMl4xx3vj65Ql0YPNWlBWFyI9RT2RHS5CqybR0Qe7ZXxYsFCN'
      });
      return Wallpaer.fromJson(data);
    } catch (e) {
      return Wallpaer();
    }
  }

//set wallpaper
  Future<bool> setWallpaperFromUrl(String imageUrl, {int? type}) async {
    bool isSet = false;
    int location;

    try {
      if (type == 1) {
        location = WallpaperManager.HOME_SCREEN;
      } else if (type == 2) {
        location = WallpaperManager.LOCK_SCREEN;
      } else {
        location = WallpaperManager.BOTH_SCREEN;
      }

      // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(imageUrl);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
      return isSet = true;
    } catch (e) {
      return isSet;
    }
  }
//set wallpaper

//Download wallpaper
  Future<bool> downloadWallpaperFromUrl(String imageUrl) async {
    // Get the image url.
    // Download the image.
    httpClient.Response response = await httpClient.get(Uri.parse(imageUrl));

    // Get the image bytes.
    Uint8List imageBytes = response.bodyBytes;

    // Download the image.

    // var success = await ImageGallerySaver.saveImage(imageBytes);
    Map<dynamic, dynamic> result =
        await ImageGallerySaver.saveImage(imageBytes);

    if (result['isSuccess']) {
      print(
          "Image downloaded and saved successfully. File path: ${result['filePath']}");
      return true;
    } else {
      print("Image download failed. Error message: ${result['errorMessage']}");
      return false;
    }

    // Check if the download was successful.
  }
}
