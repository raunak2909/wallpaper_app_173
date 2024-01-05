// ignore_for_file: public_member_api_docs, sort_constructors_first
class SrcModel {
  String? landscape;
  String? large;
  String? large2x;
  String? medium;
  String? original;
  String? portrait;
  String? small;
  String? tiny;
  SrcModel({
    required this.landscape,
    required this.large,
    required this.large2x,
    required this.medium,
    required this.original,
    required this.portrait,
    required this.small,
    required this.tiny,
  });
  factory SrcModel.formJson(Map<String, dynamic> json) {
    return SrcModel(
        landscape: json['landscape'],
        large: json['large'],
        large2x: json['large2x'],
        medium: json['medium'],
        original: json['original'],
        portrait: json['portrait'],
        small: json['small'],
        tiny: json['tiny']);
  }
}

class PhotoModel {
  num? id;
  num? width;
  num? height;
  String? alt;
  String? avg_color;
  String? photographer;
  String? url;
  String? photographer_url;
  bool? liked;
  SrcModel? src;
  num? photographer_id;
  PhotoModel({
    required this.id,
    required this.width,
    required this.height,
    required this.alt,
    required this.avg_color,
    required this.photographer,
    required this.url,
    required this.photographer_url,
    required this.liked,
    required this.src,
    required this.photographer_id,
  });
  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        id: json['id'],
        width: json['width'],
        height: json['height'],
        alt: json['alt'],
        avg_color: json['avg_color'],
        photographer: json['photographer'],
        url: json['url'],
        photographer_url: json['photographer_url'],
        liked: json['liked'],
        src: SrcModel.formJson(json['src']),
        photographer_id: json['photographer_id']);
  }
}

class WallpaperDataModel {
  num? page;
  num? per_page;
  List<PhotoModel>? photos;
  num? total_results;
  String? next_page;
  WallpaperDataModel({
    required this.page,
    required this.per_page,
    required this.photos,
    required this.total_results,
    required this.next_page,
  });
  factory WallpaperDataModel.fromJson(Map<String, dynamic> json) {
    List<PhotoModel> listPhotos = [];

    for (Map<String, dynamic> eachMap in json['photos']) {
      listPhotos.add(PhotoModel.fromJson(eachMap));
    }
    return WallpaperDataModel(
      page: json['page'],
      per_page: json['per_page'],
      photos: listPhotos,
      total_results: json['total_results'],
      next_page: json['next_page'],
    );
  }
}
