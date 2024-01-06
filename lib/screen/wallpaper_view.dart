// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class WallpaperView extends StatelessWidget {
  WallpaperView({super.key, required this.image});
  String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              image,
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
                      onTap: () {},
                      icon: Icons.save_alt_rounded),
                  stackedButton(
                      btName: 'Apply', onTap: () {}, icon: Icons.edit),
                ],
              ),
            ),
          )
        ],
      ),
    );
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
