// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

List<String> listCategory = [
  'Winter',
  'Gradient',
  'Paper',
  'Trees',
  'School',
  'Cooking',
  'Smoke',
  'Walking',
  'Spring',
  'Love',
  'Business-Meeting',
  'Burj-Khalifa',
  'Graphic-Design',
  'Exercise',
  'London',
  'January',
  'Learning',
  'Hacker',
  'Team',
  'Winter',
];

// List<String> listColorCategory = [
//   'red',
//   'orange',
//   'yellow',
//   'green',
//   'turquoise',
//   'blue',
//   'violet',
//   'pink',
//   'brown',
//   'black',
//   'gray',
//   'white'
// ];
// List<Color> listColor = [
//   Colors.red,
//   Colors.orange,
//   Colors.yellow,
//   Colors.green,
//   const Color(0xff30D5C8),
//   Colors.blue,
//   const Color(0xff7F00FF),
//   Colors.pink,
//   Colors.brown,
//   Colors.black,
//   Colors.grey,
//   Colors.white
// ];
List<ColorModel> listColorModel = [
  ColorModel(color: Colors.red, name: 'Red'),
  ColorModel(color: Colors.orange, name: 'Orange'),
  ColorModel(color: Colors.yellow, name: 'Yellow'),
  ColorModel(color: Colors.green, name: 'Green'),
  ColorModel(color: const Color(0xff30D5C8), name: 'Turquoise'),
  ColorModel(color: Colors.blue, name: 'Blue'),
  ColorModel(color: const Color(0xff7F00FF), name: 'Violet'),
  ColorModel(color: Colors.pink, name: 'Pink'),
  ColorModel(color: Colors.brown, name: 'Brown'),
  ColorModel(color: Colors.black, name: 'Black'),
  ColorModel(color: Colors.grey, name: 'Grey'),
  ColorModel(color: Colors.white, name: 'White'),
];

class ColorModel {
  Color? color;
  String? name;
  ColorModel({
    required this.color,
    required this.name,
  });
}

int selectedIndex = 0;
