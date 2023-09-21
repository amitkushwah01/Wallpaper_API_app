import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper/db_helper.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:wallpaper/wallpaper_repository.dart';

import '../../my_exception.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  WallpaperBloc() : super(WallpaperInitial()) {
    on<TrandingWallaperEvent>((event, emit) async {
      emit(WallpaperLoading());
      Wallpaer getwallpaer = await WallpaperRepository().gettrandingwallpaper();

      // emit(WallpaperLoaded(getwallpaer));

      // emit(WallpaperError("error can not load wallpaper"));

      if ((getwallpaer).photos == null) {
        emit(WallpaperError("error"));
      } else {
        emit(WallpaperLoaded(getwallpaer));
      }
    });

    on<SearchWallpaperEvent>((event, emit) async {
      emit(WallpaperLoading());
      Wallpaer getwallpaper = await WallpaperRepository().getWallpaper(
        event.mqueary,
      );
      try {
        if ((getwallpaper).photos == null) {
          emit(WallpaperError("error"));
        } else {
          emit(WallpaperLoaded(getwallpaper));
        }
      } catch (e) {
        if (e is MyException) {
          emit(WallpaperError(e.toString()));
        }
      }
    });

    on<AddFavWallpaperEvent>((event, emit) async {
      emit(FavWallpaperLoading());
      Dbhelper().addfavwalllpaper(event.url);
      List<Map<String, dynamic>> favwallpaper = await Dbhelper().fetchdata();
      emit(FavWallpaperLoaded(favwallpaper));
    });

    on<GetFavWallpaperEvent>((event, emit) async {
      emit(FavWallpaperLoading());
      List<Map<String, dynamic>> favwallpaper = await Dbhelper().fetchdata();
      emit(FavWallpaperLoaded(favwallpaper));
    });
    on<DeleteFavWallpaperEvent>((event, emit) async {
      emit(FavWallpaperLoading());
      Dbhelper().deletefavwalllpaper(event.id);
      List<Map<String, dynamic>> favwallpaper = await Dbhelper().fetchdata();
      emit(FavWallpaperLoaded(favwallpaper));
    });
  }
}
