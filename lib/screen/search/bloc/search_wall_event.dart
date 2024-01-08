part of 'search_wall_bloc.dart';

@immutable
abstract class SearchWallEvent {}


class GetSearchWallPaper extends SearchWallEvent{
  String query;
  String colorCode;
  GetSearchWallPaper({required this.query, this.colorCode = ""});
}
