import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/images_model.dart';

class ImageRepository {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/photos';

  Future<List<ImagesModel>> getModel() async {
    print('**** Inside getModel() ****');
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      print('**** Inside response.statusCode == 200 ****');
      final List<ImagesModel> images = [];
      final List<dynamic> data = json.decode(response.body);
      data.forEach((element) {
        images.add(ImagesModel.fromJson(element));
      });
      return images;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
