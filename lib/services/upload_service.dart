import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosweb/global/environment.dart';

class FileUploadService with ChangeNotifier {
  final _storage = new FlutterSecureStorage();
  PickedFile fotoaux;

  Future<String> actualizarFoto(PickedFile archivo, String id) async {
    final token = await this._storage.read(key: 'token');

    Map<String, String> headers = {"x-token": token};

    var request = http.MultipartRequest(
        'put', Uri.parse(Environment.apiUrl + '/upload/usuarios/$id'));
    request.headers.addAll(headers);

    request.files
        .add(await http.MultipartFile.fromPath('imagen', archivo.path));
    var streamResponse = await request.send();

    final res = await http.Response.fromStream(streamResponse);

    if (res.statusCode != 200 && res.statusCode != 201) {
      print('Algo salio mal');
      return null;
    }

    final respData = json.decode(res.body);
    print(respData['nombreArchivo']);
    return respData['nombreArchivo'];
  }
}
