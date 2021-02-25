import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

class FileUploadService with ChangeNotifier {
  // final _storage = new FlutterSecureStorage();
  // PickedFile fotoaux;

  Future<String> subirImagen(PickedFile imagen) async {
    // File image = File(imagen.path);
    PickedFile image = imagen;
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dv9xxxu5w/image/upload?upload_preset=ftfu4vhy');
    final mimeType = mime(image.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }

  // Future<String> actualizarFoto(PickedFile archivo, String id) async {
  //   // final token = await this._storage.read(key: 'token');

  //   Map<String, String> headers = {"x-token": token};

  //   var request = http.MultipartRequest(
  //       'put', Uri.parse(Environment.apiUrl + '/upload/usuarios/$id'));
  //   request.headers.addAll(headers);

  //   request.files
  //       .add(await http.MultipartFile.fromPath('imagen', archivo.path));
  //   var streamResponse = await request.send();

  //   final res = await http.Response.fromStream(streamResponse);

  //   if (res.statusCode != 200 && res.statusCode != 201) {
  //     print('Algo salio mal');
  //     return null;
  //   }

  //   final respData = json.decode(res.body);
  //   print(respData['nombreArchivo']);
  //   return respData['nombreArchivo'];
  // // }
}
