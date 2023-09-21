part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperState {}

class WallpaperInitial extends WallpaperState {}

class WallpaperLoading extends WallpaperState {}

class WallpaperLoaded extends WallpaperState {
  Wallpaer wallpaper;
  WallpaperLoaded(this.wallpaper);
}

class WallpaperError extends WallpaperState {
  String errormsg;
  WallpaperError(this.errormsg);
}

class FavWallpaperLoading extends WallpaperState {}

class FavWallpaperLoaded extends WallpaperState {
  List<Map<String, dynamic>> favwallpaper;
  FavWallpaperLoaded(this.favwallpaper);
}
