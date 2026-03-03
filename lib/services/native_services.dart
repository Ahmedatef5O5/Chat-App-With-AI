import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class NativeServices {
  final _imagePicker = ImagePicker();
  final _audioRecorder = AudioRecorder();

  // select an image
  Future<File?> pickImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(source: source);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  // select a file
  Future<File?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        withData: false,
        withReadStream: false,
        lockParentWindow: true,
      );

      return result != null ? File(result.files.single.path!) : null;
    } on PlatformException catch (e) {
      debugPrint("Platform Error : $e");
      return null;
    } catch (e) {
      debugPrint("General Error picking file: $e");
      return null;
    }
  }

  // record audio
  Future<void> startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // final dir = await getTemporaryDirectory();
        // final path = '${dir.path}/audio_msg.m4a';
        final directory = await getApplicationDocumentsDirectory();
        final path =
            '${directory.path}/record_${DateTime.now().millisecondsSinceEpoch}.m4a';
        await _audioRecorder.start(const RecordConfig(), path: path);
      }
    } catch (e) {
      debugPrint('Error Starting record: $e');
    }
  }

  Future<String?> stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      return path;
    } catch (e) {
      debugPrint('Error Stoping record: $e');
      return null;
    }
    // return await _audioRecorder.stop();
  }
}
