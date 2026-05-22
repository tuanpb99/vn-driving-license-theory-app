import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RemoteSyncService {
  const RemoteSyncService({required this.client});

  final http.Client client;

  Future<File> downloadJson({required Uri uri}) async {
    final response = await client.get(uri);
    if (response.statusCode != 200) {
      throw HttpException('Failed to download questions json: ${response.statusCode}');
    }

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/questions.latest.json');
    await file.writeAsString(response.body);
    return file;
  }

  Future<List<File>> cacheImages(List<String> urls) async {
    final dir = await getApplicationDocumentsDirectory();
    final imageDir = Directory('${dir.path}/question_images');
    if (!imageDir.existsSync()) {
      imageDir.createSync(recursive: true);
    }

    final files = <File>[];
    for (final url in urls) {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final filename = url.split('/').last;
        final file = File('${imageDir.path}/$filename');
        await file.writeAsBytes(response.bodyBytes);
        files.add(file);
      }
    }
    return files;
  }

  Future<Map<String, dynamic>> readLocalJson(File file) async {
    final content = await file.readAsString();
    return json.decode(content) as Map<String, dynamic>;
  }
}
