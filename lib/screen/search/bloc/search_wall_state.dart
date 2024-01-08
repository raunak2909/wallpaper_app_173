part of 'search_wall_bloc.dart';

@immutable
abstract class SearchWallState {}

class SearchWallInitialState extends SearchWallState {}
class SearchWallLoadingState extends SearchWallState {}
class SearchWallLoadedState extends SearchWallState {
  WallpaperDataModel mData;
  SearchWallLoadedState({required this.mData});
}
class SearchWallErrorState extends SearchWallState {
  String errorMsg;
  SearchWallErrorState({required this.errorMsg});
}
