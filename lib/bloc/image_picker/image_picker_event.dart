part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}


class CameraCaptureEvent extends ImagePickerEvent {}

class GalleryPickerEvent extends ImagePickerEvent {}