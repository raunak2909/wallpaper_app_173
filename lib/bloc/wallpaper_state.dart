part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperState {}

class WallpaperInitialState extends WallpaperState {}
class WallpaperLoadingState extends WallpaperState {}
class WallpaperLoadedState extends WallpaperState {
  WallpaperDataModel mData;
  WallpaperLoadedState({required this.mData});
}
class WallpaperErrorState extends WallpaperState {
  String errorMsg;
  WallpaperErrorState({required this.errorMsg});
}
