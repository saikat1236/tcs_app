// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fpdart/fpdart.dart';

// import '../failure.dart';
// import '../type_defs.dart';
// import '../utils.dart';
// import 'firebase_providers.dart';

// final storageRepositoryProvider = Provider(
//   (ref) => StorageRepository(
//     firebaseStorage: ref.watch(storageProvider),
//   ),
// );

// class StorageRepository {
//   final FirebaseStorage _firebaseStorage;

//   StorageRepository({required FirebaseStorage firebaseStorage})
//       : _firebaseStorage = firebaseStorage;

//   FutureEither<String> storeFile({
//     required String path,
//     required String id,
//     required File? file,
//     required Uint8List? webFile,
//   }) async {
//     try {
//       final ref = _firebaseStorage.ref().child(path).child(id);
//       UploadTask uploadTask;

//       if (kIsWeb) {
//         uploadTask = ref.putData((await compressImage(webFile))!);
//       } else {
//         uploadTask = ref.putData((await compressImage(file))!);
//       }

//       final snapshot = await uploadTask;

//       return right(await snapshot.ref.getDownloadURL());

//       // if (file.path.toLowerCase().endsWith(".jpg") ||
//       //     file.path.toLowerCase().endsWith(".png") ||
//       //     file.path.toLowerCase().endsWith(".bmp") ||
//       //     file.path.toLowerCase().endsWith(".tiff") ||
//       //     file.path.toLowerCase().endsWith(".jpeg")) {
//       //   UploadTask uploadTask;
//       //   if (kIsWeb) {
//       //     uploadTask = _firebaseStorage
//       //         .ref()
//       //         .child(path)
//       //         .child(id)
//       //         .putData((await compressImage(file))!);
//       //   }else{
//       //     uploadTask = _firebaseStorage
//       //         .ref()
//       //         .child(path)
//       //         .child(id)
//       //         .putData((await compressImage(webFile))!);
//       //   }
//       //   TaskSnapshot snap = await uploadTask;
//       //   String downloadUrl = await snap.ref.getDownloadURL();
//       //   return right(downloadUrl);
//       // } else {
//       //   UploadTask uploadTask =
//       //       _firebaseStorage.ref().child(path).child(id).putFile(file);
//       //   TaskSnapshot snap = await uploadTask;
//       //   String downloadUrl = await snap.ref.getDownloadURL();
//       //   return right(downloadUrl);
//       // }
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }
// }
