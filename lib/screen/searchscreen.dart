import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;
import 'package:wallpaper_app/models/api_model.dart';
import 'package:wallpaper_app/screen/homeScreen.dart';
import 'package:wallpaper_app/screen/wallpaper_view.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, required this.upComingsearch});
  String? upComingsearch;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  WallpaperDataModel? searchModel;
  var searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllSearchResults(search: '${widget.upComingsearch}');
  }

  getAllSearchResults({required String search,}) async {
    var apiKey = " WuSQl2o2WCR4yEHwD4fijNKVEptdFzfuFSAqPcRlie2uNuvZQnhBDMRC";
    var uri = Uri.parse('https://api.pexels.com/v1/search?query=$search');
    var response =
        await httpClient.get(uri, headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      var rowData = jsonDecode(response.body);
      searchModel = WallpaperDataModel.fromJson(rowData);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search Photos'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              mySearchTextField(),
              const SizedBox(height: 20),
              searchModel != null && searchModel!.photos!.isNotEmpty
                  ? searchPhotosGridView()
                  : const Center(
                      child: Text('Search Not Found'),
                    ),
            ]),
          ),
        ));
  }

  TextField mySearchTextField() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              getAllSearchResults(search: searchController.text.toString());
              setState(() {});
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
    );
  }

  GridView searchPhotosGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchModel!.photos!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 1.2 / 2),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return WallpaperView(
                  image: searchModel!.photos![index].src!.portrait.toString(),
                );
              },
            ));
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        '${searchModel!.photos![index].src!.landscape}'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12),
                color: Colors.green),
            height: 120,
          ),
        );
      },
    );
  }
}
