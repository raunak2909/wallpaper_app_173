// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper/wallpaper.dart';

class WallpaperView extends StatelessWidget {
  WallpaperView({super.key, required this.imageUrl});
  String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  stackedButton(btName: 'Info', onTap: () {}, icon: Icons.info),
                  stackedButton(
                      btName: 'Save',
                      onTap: () {
                        saveWallpaper(context);
                      },
                      icon: Icons.save_alt_rounded),
                  stackedButton(
                      btName: 'Apply', onTap: () {
                        applyWallpaper(context);
                  }, icon: Icons.edit),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void applyWallpaper(BuildContext context){
    //Wallpaper
    var imgStream = Wallpaper.imageDownloadProgress(imageUrl);

    imgStream.listen((event) {
      print("Event : $event");
    }, onDone: () async{
      //set wallpaper

      var check = await Wallpaper.homeScreen(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        options: RequestSizeOptions.RESIZE_FIT
      );

      print("Result: $check");

    }, onError: (e){
      print("Error: $e");
    });

  }

  void saveWallpaper(BuildContext context){
    //GallerySaver
    GallerySaver.saveImage(imageUrl).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wallpaper saved!!')));
      print('Wallpaper saved: $value');});
  }

  Column stackedButton(
      {required String btName,
      required VoidCallback onTap,
      required IconData icon}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          style: IconButton.styleFrom(
              highlightColor: const Color(0xff3f64f5),
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: const Color(0xffc3bdb8).withOpacity(0.3)),
          icon: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          onPressed: onTap,
        ),
        const SizedBox(height: 4),
        Text(
          btName,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
