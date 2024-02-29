import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class HttpUtils{
  Future<List<http.MultipartFile>> convertFilesToMultipart(List<File> files) async {
    List<http.MultipartFile> multipartFiles = [];

    for (File file in files) {
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'pictures', // Nome do campo no servidor
        stream,
        length,
        filename: basename(file.path), // Nome do arquivo
      );
      multipartFiles.add(multipartFile);
    }

    return multipartFiles;
  }
}