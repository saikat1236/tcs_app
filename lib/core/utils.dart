// import 'dart:typed_data';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}
InputDecoration inputDecoration({
  required String title,
  required IconData icon,
}) {
  return InputDecoration(
    labelText: title,
    prefixIcon: Icon(icon, color: Colors.grey.shade800),
    labelStyle: TextStyle(color: Colors.grey.shade800),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
  );
}

// Future<FilePickerResult?> pickImage() async {
//   final image = await FilePicker.platform.pickFiles(type: FileType.image);

//   return image;
// }
// Future<Uint8List?> compressImage(dynamic imageFile) async {
//   var result = await FlutterImageCompress.compressWithFile(imageFile.absolute.path, quality: 40, minHeight: 1280, minWidth: 1280);
//   // FlutterImageCompress.c+
//   return result;
// }
