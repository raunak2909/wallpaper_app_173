// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as httpClient;
import 'package:wallpaper_app/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/data_source/remote/api_helper.dart';
import 'package:wallpaper_app/models/api_model.dart';
import 'package:wallpaper_app/screen/category_Screen.dart';
import 'package:wallpaper_app/screen/search/bloc/search_wall_bloc.dart';
import 'package:wallpaper_app/screen/search/ui/searchscreen.dart';
import 'package:wallpaper_app/constrain/variables.dart';
import 'package:wallpaper_app/screen/wallpaper_view.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  WallpaperDataModel? wallpaperDataModel;
  TextEditingController searchController = TextEditingController();
  WallpaperDataModel? categoryDataModel;

  @override
  void initState() {
    super.initState();
    //getPhotosCurated();
    BlocProvider.of<WallpaperBloc>(context).add(GetTrendingWallpaper());
    getPhotosByCategory('popular-searches');
  }

  /* getPhotosCurated() async {
    var apiKey = " WuSQl2o2WCR4yEHwD4fijNKVEptdFzfuFSAqPcRlie2uNuvZQnhBDMRC";
    var uri = Uri.parse('https://api.pexels.com/v1/curated');
    var response =
        await httpClient.get(uri, headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      var rowData = jsonDecode(response.body);
      wallpaperDataModel = WallpaperDataModel.fromJson(rowData);
      setState(() {});
    }
  }*/

  getPhotosByCategory(String category) async {
    var apiKey = " WuSQl2o2WCR4yEHwD4fijNKVEptdFzfuFSAqPcRlie2uNuvZQnhBDMRC";
    var uri = Uri.parse('https://api.pexels.com/v1/search?query=$category');
    var response =
        await httpClient.get(uri, headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      var rowData = jsonDecode(response.body);
      categoryDataModel = WallpaperDataModel.fromJson(rowData);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              homeScreenSearchTextField(context),
              bestofMonthTitle(),
              bestofMonthView(),
              theColorToneTitle(),
              theColorTone(context),
              categoryTitle(),
              //categoryView()
            ],
          ),
        )
        //: const Center(child: CircularProgressIndicator.adaptive()),
        );
  }

  Padding homeScreenSearchTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) =>
                          SearchWallBloc(apiHelper: ApiHelper()),
                      child: SearchScreen(
                        upComingsearch: searchController.text.toString(),
                        colorCode: null,
                      ),
                    );
                  },
                ));
              },
              icon: const Icon(
                CupertinoIcons.search,
                color: Colors.grey,
                size: 29,
              ),
            ),
            hintText: 'Find Wallpaper...',
            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
            filled: true,
            fillColor: const Color(0xffeef3f5),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none)),
      ),
    );
  }

  Padding categoryTitle() {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Text('Categories',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }

  SingleChildScrollView categoryView() {
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoryDataModel!.photos!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                selectedIndex = index;
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CategoryScreen(
                      isCategory: true,
                    );
                  },
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            '${categoryDataModel!.photos![index].src!.landscape}'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green),
                height: 120,
                child: Center(
                    child: Text(
                  listCategory[index],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bestofMonthView() {
    return BlocBuilder<WallpaperBloc, WallpaperState>(
      builder: (context, state) {
        if (state is WallpaperLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WallpaperErrorState) {
          return Center(
            child: Text(state.errorMsg),
          );
        } else if (state is WallpaperLoadedState) {
          wallpaperDataModel = state.mData;
          return Container(
            // width: 200,
            height: 220,
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: wallpaperDataModel!.photos!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.9 / 1.19,
                    crossAxisCount: 1),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return WallpaperView(
                            image: wallpaperDataModel!
                                .photos![index].src!.portrait
                                .toString(),
                          );
                        },
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          image: DecorationImage(
                              image: NetworkImage(
                                  '${wallpaperDataModel!.photos![index].src!.portrait}'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Padding theColorToneTitle() {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        'The color Tone',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Padding bestofMonthTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        'Best of the month',
        style: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  SingleChildScrollView BestOFTheMonth() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: wallpaperDataModel!.photos!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.9 / 1.19,
              crossAxisCount: 1),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  image: DecorationImage(
                      image: NetworkImage(
                          '${wallpaperDataModel!.photos![index].src!.portrait}'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12)),
            );
          },
        ),
      ),
    );
  }

  GridView bestOFMonthGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: wallpaperDataModel!.photos!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.9 / 1.19,
          crossAxisCount: 1),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.green.shade200,
              image: DecorationImage(
                  image: NetworkImage(
                      '${wallpaperDataModel!.photos![index].src!.portrait}'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12)),
        );
      },
    );
  }

  SizedBox theColorTone(BuildContext context) {
    return SizedBox(
        height: 65,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: listColorModel.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {

                        /*selectedIndex = index;*/
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                      SearchWallBloc(apiHelper: ApiHelper()),
                                  child: SearchScreen(
                                    upComingsearch:
                                    searchController.text.toString().isNotEmpty
                                        ? searchController.text.toString()
                                        : "",
                                    colorCode: listColorModel[index].name,
                                  ),
                                )
                          ));
                      },
                      child: Container(
                          width: 65,
                          decoration: BoxDecoration(
                              border:
                                  listColorModel[index].color == Colors.white
                                      ? Border.all(color: Colors.black)
                                      : null,
                              borderRadius: BorderRadius.circular(12),
                              color: listColorModel[index].color)),
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ));
  }
}
