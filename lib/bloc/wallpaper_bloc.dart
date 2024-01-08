import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/data_source/remote/app_exception.dart';
import 'package:wallpaper_app/data_source/remote/urls.dart';
import 'package:wallpaper_app/models/api_model.dart';

import '../data_source/remote/api_helper.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  ApiHelper apiHelper;
  WallpaperBloc({required this.apiHelper}) : super(WallpaperInitialState()) {
    on<GetTrendingWallpaper>((event, emit) async {
      emit(WallpaperLoadingState());

      try{
        var rawData = await apiHelper.getAPI(Urls.TRENDING_WALLPAPER_URL);
        ///loaded state
        var wallpaperDataModel = WallpaperDataModel.fromJson(rawData);
        emit(WallpaperLoadedState(mData: wallpaperDataModel));
      } catch (e){
        ///error state
        emit(WallpaperErrorState(errorMsg: (e as AppException).toErrorMsg()));
      }

    });
  }
}
