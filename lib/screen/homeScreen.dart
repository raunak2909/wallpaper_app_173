// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;
import 'package:wallpaper_app/models/api_model.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  void initState() {
    super.initState();
    getPhotosByCategory();
  }

  WallpaperDataModel? wallpaperDataModel;

  getPhotosByCategory() async {
    var apiKey = " WuSQl2o2WCR4yEHwD4fijNKVEptdFzfuFSAqPcRlie2uNuvZQnhBDMRC";
    var uri = Uri.parse('https://api.pexels.com/v1/search?query=Nature');
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
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: wallpaperDataModel != null && wallpaperDataModel!.photos!.isNotEmpty
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
        itemCount: wallpaperDataModel!.photos!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green,
                  image: DecorationImage(
                      image: NetworkImage(wallpaperDataModel!
                          .photos![index].src!.landscape
                          .toString()),
                      fit: BoxFit.cover)),
              height: 120,
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
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: Colors.accents.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                    width: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.primaries[index])),
              );
            },
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