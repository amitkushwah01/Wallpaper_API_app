import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  var fav_table = "note";
  var favWallpaperId = "wallpaper_id";
  var favWallpaperUrl = "wallpaper_Url";

  Future<Database> openDB() async {
    var director = await getApplicationDocumentsDirectory();
    // we use recursive true because we create directory only first time
    await director.create(recursive: true);
    var path = director.path + "fav_db.db";
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "create table $fav_table ( $favWallpaperId integer primary key  autoincrement ,"
            " $favWallpaperUrl text )");
      },
    );
  }

  void addfavwalllpaper(String url) async {
    var mydb = await openDB();
    mydb.insert(fav_table, {favWallpaperUrl: url});
  }

  Future<List<Map<String, dynamic>>> fetchdata() async {
    var myDb = await openDB();
    return myDb.query(fav_table);
  }

  void deletefavwalllpaper(int id) async {
    var myDB = await openDB();
    myDB.delete(fav_table, where: '$favWallpaperId=?', whereArgs: ['$id']);
  }
}
