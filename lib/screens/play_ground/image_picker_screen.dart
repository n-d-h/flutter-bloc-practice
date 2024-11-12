import 'dart:io';

import 'package:bloc_learner/bloc/image_picker/image_picker_bloc.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Screen'),
      ),
      body: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state.file != null)
                  Image.file(
                    File(state.file!.path),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 500,
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<ImagePickerBloc>().add(GalleryPickerEvent());
                  },
                  child: const SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt),
                        SizedBox(width: 10),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                  onLongPress: () {
                    context.read<ImagePickerBloc>().add(CameraCaptureEvent());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
