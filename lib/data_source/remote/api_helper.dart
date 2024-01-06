import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/data_source/remote/app_exception.dart';
import 'package:wallpaper_app/data_source/remote/urls.dart';

class ApiHelper{


  Future<dynamic> getAPI(String url, {Map<String, String>? headers}) async{
    var uri = Uri.parse(url);

    try {
      var response = await http.get(
          uri, headers: headers ?? {"Authorization": Urls.API_KEY});

      return returnDataResponse(response);

    } on SocketException{
      /// internet error
      throw FetchDataException(body: "Internet Error");
    }

  }

  dynamic returnDataResponse(http.Response res){

    switch(res.statusCode){

      case 200:
        ///status ok
        var actRes = res.body;
        var mData = jsonDecode(actRes);
        return mData;

      case 400:
        throw BadRequestException(body: res.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(body: res.body.toString());
      case 500:
      default:
        throw FetchDataException(
            body: 'Error occurred while Communication with Server with StatusCode : ${res.statusCode}');

    }

  }

}