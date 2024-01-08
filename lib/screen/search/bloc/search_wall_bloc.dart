import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/models/api_model.dart';

import '../../../data_source/remote/api_helper.dart';
import '../../../data_source/remote/app_exception.dart';
import '../../../data_source/remote/urls.dart';

part 'search_wall_event.dart';
part 'search_wall_state.dart';

class SearchWallBloc extends Bloc<SearchWallEvent, SearchWallState> {
  ApiHelper apiHelper;
  SearchWallBloc({required this.apiHelper}) : super(SearchWallInitialState()) {
    on<GetSearchWallPaper>((event, emit) async {
      emit(SearchWallLoadingState());

      try{
        var mainUrl = event.query.isNotEmpty ?
          "${Urls.SEARCH_WALLPAPER_URL}?query=${event.query}&color=${event.colorCode}"
        :
          "${Urls.SEARCH_WALLPAPER_URL}?query=${event.colorCode}";

        var rawData = await apiHelper.getAPI(mainUrl);
        ///loaded state
        var wallpaperDataModel = WallpaperDataModel.fromJson(rawData);
        emit(SearchWallLoadedState(mData: wallpaperDataModel));
      } catch (e){
        ///error state
        emit(SearchWallErrorState(errorMsg: (e as AppException).toErrorMsg()));
      }

    });
  }
}
