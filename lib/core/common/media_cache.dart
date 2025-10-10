// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:textmi/common/utils/shared_pref.dart';

// // import '../enums/message_enum.dart';

// class MediaCache {
// // bool isDownloadingImage = false;

//   static String androidDir =
//       "/storage/emulated/0/Android/media/com.example.final_vedanta";
// // Directory mainDir = Platform.isAndroid ? Directory(myMainDir) : await getApplicationDocumentsDirectory();
//   static late Directory mainDir;
//   static late Directory fvDir;
//   static late Directory mediaDir;

//   static late Directory imagesDir;
//   static late Directory imagesThumDir;
//   // static late Directory gifDir;
//   // static late Directory audioDir;
//   // static late Directory videoDir;
//   // static late Directory videoThumDir;
//   // static late Directory fileDir;
//   static late Directory profilePicDir;
//   // static late Directory statusDir;
//   // static late Directory chatBgDir;

//   static Future<Directory> getPrepareCacheDirectory() async {
//     if (!kIsWeb) {
//       if (Platform.isAndroid) {
//         // var str = await getExternalStorageDirectories(
//         //     type: StorageDirectory.documents);
//         var str1 = await getExternalStorageDirectory();
//         // String path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
//         mainDir = Directory(androidDir);

//         if (!mainDir.existsSync()) {
//           try {
//             await mainDir.create();
//           } catch (_) {
//             androidDir = str1!.path;
//             mainDir = Directory(androidDir);
//           }
//         }
//       } else {
//         mainDir = await getApplicationDocumentsDirectory();
//       }
//     }

//     fvDir = Directory("$androidDir/FV");
//     mediaDir = Directory("${fvDir.path}/Media");
//     imagesDir = Directory("${mediaDir.path}/FV Images");
//     imagesThumDir = Directory("${imagesDir.path}/.thumbnails");
//     // gifDir = Directory("${mediaDir.path}/Textmi Gifs");
//     // audioDir = Directory("${mediaDir.path}/Textmi Audios");
//     // videoDir = Directory("${mediaDir.path}/Textmi Videos");
//     // videoThumDir = Directory("${videoDir.path}/.thumbnails");
//     // fileDir = Directory("${mediaDir.path}/Textmi Documents");
//     profilePicDir = Directory("${mediaDir.path}/FV Profile Pics");
//     // statusDir = Directory("${mediaDir.path}/Textmi Statuses");
//     // chatBgDir = Directory("${mediaDir.path}/Textmi Chat Background Images");
//     if (!await mainDir.exists()) await mainDir.create();
//     if (!await fvDir.exists()) await fvDir.create();
//     if (!await mediaDir.exists()) await mediaDir.create();
//     return fvDir;
//   }

//   static Future<void> getPrepareCacheInternalDirectory() async {
//     if (FirebaseAuth.instance.currentUser == null) return;
//     await getPrepareCacheDirectory();

//     if (!await imagesDir.exists()) await imagesDir.create();
//     if (!await imagesThumDir.exists()) await imagesThumDir.create();
//     // if (!await gifDir.exists()) await gifDir.create();
//     // if (!await audioDir.exists()) await audioDir.create();
//     // // if (!await videoDir.exists()) await videoDir.create();
//     // // if (!await videoThumDir.exists()) await videoThumDir.create();
//     // // if (!await fileDir.exists()) await fileDir.create();
//     // // if (!await profilePicDir.exists()) await profilePicDir.create();
//     // // if (!await statusDir.exists()) await statusDir.create();
//     // // if (!await chatBgDir.exists()) await chatBgDir.create();

//     // // File fll = File("${chatBgDir.path}/.nomedia");
//     // if (!fll.existsSync()) fll.writeAsBytesSync([]);
//     // fll = File("${profilePicDir.path}/.nomedia");
//     // if (!fll.existsSync()) fll.writeAsBytesSync([]);
//     // fll = File("${statusDir.path}/.nomedia");
//     // if (!fll.existsSync()) fll.writeAsBytesSync([]);
//     // fll = File("${profilePicDir.path}/.nomedia");
//     // if (!fll.existsSync()) fll.writeAsBytesSync([]);
//   }

//   // static SharedPreferences? sharedPreferencesCaching;
//   static List<String> currentDowloadings = [];
//   static Future<File?> downloadImage(String url, String type,
//       {bool isProfilePic = false}) async {
//     // await Hive.box("images").put("time", DateTime.now());
//     // while (isDownloadingImage) {
//     //   await Future.delayed(Duration(milliseconds: 100));
//     // }
//     // isDownloadingImage = true;
//     if (currentDowloadings.contains(url)) {
//       String filename = (LocalSettings.globalSharedPref!.getString(url)) ?? "";
//       int count = 45;
//       while (filename == "") {
//         await Future.delayed(const Duration(milliseconds: 100));
//         filename = (LocalSettings.globalSharedPref!.getString(url)) ?? "";
//         if (count <= 0) {
//           return null;
//         }
//         count--;
//       }
//       while (!(await File.fromUri(Uri.parse(filename)).exists())) {
//         await Future.delayed(const Duration(milliseconds: 100));
//         if (count <= 0) {
//           return null;
//         }
//         count--;
//       }
//       return File.fromUri(Uri.parse(filename));
//     }
//     await getPrepareCacheInternalDirectory();
//     File? file;
//     LocalSettings.globalSharedPref ??= await SharedPreferences.getInstance();

//     // Directory dir1 = Directory(appDocDirectory.path + "/Textmi/Images");
//     // if (!await dir1.exists()) dir1.create();
//     String filename = (LocalSettings.globalSharedPref!.getString(url)) ?? "";

//     try {
//       if (await File.fromUri(Uri.parse(filename)).exists()) {
//         currentDowloadings.remove(url);
//         return File.fromUri(Uri.parse(filename));
//       }
//     } catch (_) {}
//     currentDowloadings.add(url);
//     file = await downloadFile(url, type, isProfilePic);
//     if (file == null) return file;
//     await LocalSettings.globalSharedPref!.setString(url, file.path);
//     // isDownloadingImage = false;
//     return file;
//   }

//   static Future<File?> downloadFile(
//       String url, String type, isProfilePic) async {
//     HttpClient httpClient = HttpClient();
//     File? file;
//     LocalSettings.globalSharedPref ??= await SharedPreferences.getInstance();
//     try {
//       var request = await httpClient.getUrl(Uri.parse(url));
//       var response = await request.close();
//       if (response.statusCode == 200) {
//         var bytes = await consolidateHttpClientResponseBytes(response);
//         if (type == 'image') {
//           if (isProfilePic) {
//             file = File(await getSetFileName("jpg", "profile", profilePicDir));
//           } else {
//             file = File(await getSetFileName("jpg", "image", imagesDir));
//           }
//           // } else if (type == MessageEnum.gif) {
//           //   file = File(await getSetFileName("gif", "gif", gifDir));
//           // } else if (type == MessageEnum.video) {
//           //   file = File(await getSetFileName("mp4", "video", videoDir));
//           // } else if (type == MessageEnum.audio) {
//           //   file = File(await getSetFileName("mp3", "audio", audioDir));
//           // }
//         }
//         await file!.writeAsBytes(bytes);
//       }
//     } catch (ex) {
//       debugPrint(ex.toString());
//     }
//     currentDowloadings.remove(url);
//     return file;
//   }

//   static Future<String> getSetFileName(
//       String ext, String name, Directory dirName) async {
//     String filename = "";
//     String dataName = "${DateFormat("yyMMdd").format(DateTime.now())}-$name";
//     if (!await dirName.exists()) await dirName.create();
//     int maxID = LocalSettings.globalSharedPref!.getInt(dataName) ?? 0;
//     do {
//       maxID += 1;
//       filename =
//           "TM-${DateFormat("yyMMdd").format(DateTime.now())}-${NumberFormat("0000").format(maxID)}.$ext";
//     } while (File("${dirName.path}/$filename").existsSync());
//     await LocalSettings.globalSharedPref!.setInt(dataName, maxID);
//     return "${dirName.path}/$filename";
//   }
// }
