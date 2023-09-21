part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperEvent {}

class TrandingWallaperEvent extends WallpaperEvent {
  TrandingWallaperEvent();
}

class SearchWallpaperEvent extends WallpaperEvent {
  String mqueary;

  SearchWallpaperEvent(
    this.mqueary,
  );
}

class AddFavWallpaperEvent extends WallpaperEvent {
  String url;
  AddFavWallpaperEvent(this.url);
}

class DeleteFavWallpaperEvent extends WallpaperEvent {
  var id;
  DeleteFavWallpaperEvent(this.id);
}

class GetFavWallpaperEvent extends WallpaperEvent {}
