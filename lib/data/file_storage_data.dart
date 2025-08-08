import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/services.dart';
import 'package:path/path.dart';

class FileStorageData {
  // static String filePath = "assets/data/book.txt";
  //
  // static Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return directory.path;
  // }
  //
  // static Future<List<String>> readDataFromFile() async {
  //   String appDocDir = await _localPath;
  //
  //   // Load data from assets
  //   // String dataStr = await rootBundle.loadString(filePath);
  //   // List<String> data = LineSplitter.split(dataStr).map((i) => i).toList();
  //
  //   // // Get File
  //   File file = File('$appDocDir/$filePath');
  //   // Check Exist
  //   if (file.exists() == false) {
  //     print("File is not exist, create new file");
  //     await file.create(recursive: true);
  //   }
  //   // Read File
  //   List<String> data = await file.readAsLines();
  //   return data;
  // }
  //
  // static Future<void> writeDataToFile(String data) async {
  //   String appDocDir = await _localPath;
  //   // Get File
  //   File file = File('$appDocDir/$filePath');
  //   // Check Exist
  //   if (file.exists() == false) {
  //     print("File is not exist, create new file");
  //     await file.create(recursive: true);
  //   }
  //   // Replace data
  //   // await file.writeAsString(data);
  //
  //   // Append data
  //   file.openWrite(mode: FileMode.append).writeln(data);
  // }
}
