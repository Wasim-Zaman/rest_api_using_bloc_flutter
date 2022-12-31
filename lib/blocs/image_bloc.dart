import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/image_repository.dart';
import '../blocs/image_events.dart';
import '../blocs/image_states.dart';

class ImageBloc extends Bloc<ImageEvents, ImageStates> {
  final ImageRepository imageRepository;

  ImageBloc(this.imageRepository) : super(ImageLoadingState()) {
    on<ImageLoadingEvent>((event, emit) => emit(ImageLoadingState()));
    on<ImageExceptionEvent>(
        (event, emit) => emit(ImageExceptionState('Error Occured!')));
    on<ImageLoadedEvent>((event, emit) async {
      try {
        final images = await imageRepository.getModel();
        emit(ImageLoadedState(images));
      } catch (e) {
        emit(ImageExceptionState(e.toString()));
      }
    });
  }
}
