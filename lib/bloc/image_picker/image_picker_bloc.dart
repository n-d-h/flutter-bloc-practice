import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_learner/utils/image_picker_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';

part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;

  ImagePickerBloc(this.imagePickerUtils) : super(const ImagePickerState()) {
    on<CameraCaptureEvent>(_onCameraCapture);
    on<GalleryPickerEvent>(_onGalleryPicker);
  }

  FutureOr<void> _onCameraCapture(
      CameraCaptureEvent event, Emitter<ImagePickerState> emit) async {
    XFile? file = await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file: file));
  }

  FutureOr<void> _onGalleryPicker(
      GalleryPickerEvent event, Emitter<ImagePickerState> emit) async {
    XFile? file = await imagePickerUtils.galleryPicker();
    emit(state.copyWith(file: file));
  }
}
