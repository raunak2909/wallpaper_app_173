// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;
import 'package:wallpaper_app/models/api_model.dart';
import 'package:wallpaper_app/screen/category_Screen.dart';
import 'package:wallpaper_app/screen/variables.dart';
import 'package:wallpaper_app/screen/wallpaper_view.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});
  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  WallpaperDataModel? wallpaperDataModel;
  WallpaperDataModel? categoryDataModel;

  @override
  void initState() {
    super.initState();
    getPhotosByCategory('nature');
    getPhotosByCategory('popular-searches');
  }

  getPhotosByCategory(String category) async {
    var apiKey = " WuSQl2o2WCR4yEHwD4fijNKVEptdFzfuFSAqPcRlie2uNuvZQnhBDMRC";
    var uri = Uri.parse('https://api.pexels.com/v1/search?query=$category');
    var response =
        await httpClient.get(uri, headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      if (category != 'popular-searches') {
        var rowData = jsonDecode(response.body);
        wallpaperDataModel = WallpaperDataModel.fromJson(rowData);
        setState(() {});
      } else {
        var rowData = jsonDecode(response.body);
        categoryDataModel = WallpaperDataModel.fromJson(rowData);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: wallpaperDataModel != null &&
              wallpaperDataModel!.photos!.isNotEmpty &&
              categoryDataModel != null &&
              categoryDataModel!.photos!.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchTextField(),
                  bestofMonthTitle(),
                  bestofMonthView(),
                  theColorToneTitle(),
                  theColorTone(),
                  categoryTitle(),
                  categoryView()
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
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

  Container bestofMonthView() {
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
                      image: wallpaperDataModel!.photos![index].src!.portrait
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

  Padding searchTextField() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
            suffixIcon: const Icon(
              CupertinoIcons.search,
              color: Colors.grey,
              size: 29,
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

  SizedBox theColorTone() {
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
                itemCount: listColor.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        selectedIndex = index;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryScreen(isCategory: false),
                            ));
                      },
                      child: Container(
                          width: 65,
                          decoration: BoxDecoration(
                              border: listColor[index] == Colors.white
                                  ? Border.all(color: Colors.black)
                                  : null,
                              borderRadius: BorderRadius.circular(12),
                              color: listColor[index])),
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
}

// Image.network(
//                         "${wallpaperDataModel!.photos![index].src!.portrait}");