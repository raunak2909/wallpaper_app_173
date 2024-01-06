import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/data_source/remote/api_helper.dart';
import 'package:wallpaper_app/screen/homeScreen.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => WallpaperBloc(apiHelper: ApiHelper()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wallpaper App',
      debugShowCheckedModeBanner: false,
      home: MyHomeScreen(),
    );
  }
}
