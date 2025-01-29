import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:nbt_team17/defaults/app_defaults.dart';

class FileManager {

  /// Reads images.json and loads image specified by imageId
  Future<Image> loadImage(String imageKey) async {
    try {
      // Retrieve from file
      String file = 'assets/badges.json';
      Map<String, dynamic> data = jsonDecode(await rootBundle.loadString(file));
      if (data[imageKey] == null) {
        throw Exception('No photo available');
      }

      final base64Image = base64Decode(data[imageKey]);
      return Image.memory(base64Image);
    } on Exception catch (_) {
      // Exception :: no photo available
      // assert :: loadImage is only called if there exists a character with this image (should've been downloaded already)
      final base64Image = base64Decode(AppDefaults.noPhotoAvailable);
      return Image.memory(base64Image);
    }
  }
}