import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  final ImagePicker _image = ImagePicker();

  Future<XFile?> cameraCapture() async {
    final XFile? image = await _image.pickImage(source: ImageSource.camera);
    if (image != null) {
      return image;
    }
    return null;
  }

  Future<XFile?> galleryPicker() async {
    final XFile? image = await _image.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image;
    }
    return null;
  }
}
