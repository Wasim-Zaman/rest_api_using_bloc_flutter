import '../models/images_model.dart';

abstract class ImageEvents {}

class ImageLoadingEvent extends ImageEvents {}

class ImageExceptionEvent extends ImageEvents {
  final String message;

  ImageExceptionEvent(this.message);
}

class ImageLoadedEvent extends ImageEvents {
  final List<ImagesModel> images;

  ImageLoadedEvent(this.images);
}
