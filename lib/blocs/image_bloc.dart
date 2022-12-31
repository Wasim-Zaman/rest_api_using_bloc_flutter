import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/image_repository.dart';
import '../blocs/image_events.dart';
import '../blocs/image_states.dart';

class ImageBloc extends Bloc<ImageEvents, ImageStates> {
  final ImageRepository imageRepository;

  ImageBloc(this.imageRepository) : super(ImageLoadingState()) {
    // loading event
    on<ImageLoadingEvent>((event, emit) => emit(ImageLoadingState()));
    // exception event
    on<ImageExceptionEvent>(
        (event, emit) => emit(ImageExceptionState('Error Occured!')));
    // data loaded event
    on<ImageLoadedEvent>((event, emit) async {
      // before the data is actually fetched, we emit the loading state
      emit(ImageLoadingState());
      try {
        final images = await imageRepository.getModel();
        emit(ImageLoadedState(images));
      } catch (e) {
        emit(ImageExceptionState(e.toString()));
      }
    });
  }
}
