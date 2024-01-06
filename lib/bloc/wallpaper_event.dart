part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperEvent {}

class GetTrendingWallpaper extends WallpaperEvent{}

class GetSearchWallPaper extends WallpaperEvent{
  String query;
  GetSearchWallPaper({required this.query});
}
