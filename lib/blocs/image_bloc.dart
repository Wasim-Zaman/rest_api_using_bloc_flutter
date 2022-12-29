import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'image_events.dart';
import 'image_states.dart';
import '../models/images_model.dart';

class ImageBloc extends Bloc<ImageEvents, ImageStates> {
  ImageBloc() : super(ImageLoadingState()) {
    const url = 'https://jsonplaceholder.typicode.com/photos';
    List<ImagesModel> images = [];
    on<ImageLoadingEvent>((event, emit) async {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          data.forEach((element) {
            images.add(ImagesModel.fromJson(element));
          });
          emit(ImageLoadedState(images));
        } else {
          emit(ImageExceptionState('Error'));
        }
      } catch (e) {
        emit(ImageExceptionState(e.toString()));
      }
    });
  }
}
