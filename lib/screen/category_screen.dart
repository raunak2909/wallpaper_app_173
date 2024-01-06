// ignore_for_file: library_prefixes, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/api_model.dart';
import 'package:http/http.dart' as httpClient;
import 'package:wallpaper_app/constrain/variables.dart';
import 'package:wallpaper_app/screen/wallpaper_view.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key, this.isCategory = true});
  bool isCategory;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  WallpaperDataModel? wallpaperDataModel;
  @override
  void initState() {
    super.initState();

    if (widget.isCategory) {
      getPhotosByCategory(listCategory[selectedIndex]);
    } else {
      getPhotosByCategory(
        listColorModel[selectedIndex].name.toString(),
      );
    }
  }

// ,mcolor: listColorModel[selectedIndex].name.toString()
  getPhotosByCategory(String category) async {
    var apiKey = " WuSQl2o2WCR4yEHwD4fijNKVEptdFzfuFSAqPcRlie2uNuvZQnhBDMRC";
    var uri = Uri.parse('https://api.pexels.com/v1/search?query=$category');
    var response =
        await httpClient.get(uri, headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      var rowData = jsonDecode(response.body);
      wallpaperDataModel = WallpaperDataModel.fromJson(rowData);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isCategory
              ? listCategory[selectedIndex]
              : listColorModel[selectedIndex].name.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: wallpaperDataModel != null && wallpaperDataModel!.photos!.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [categoryImageWallpaper()],
              ),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  GridView categoryImageWallpaper() {
    return GridView.builder(
      itemCount: wallpaperDataModel!.photos!.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 5,
          crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: InkWell(
            onTap: () {
              var selectedIndex = index;
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return WallpaperView(
                      image: wallpaperDataModel!
                          .photos![selectedIndex].src!.portrait
                          .toString());
                },
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(wallpaperDataModel!
                          .photos![index].src!.portrait
                          .toString()),
                      fit: BoxFit.cover)),
            ),
          ),
        );
      },
    );
  }
}
