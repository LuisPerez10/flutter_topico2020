import 'dart:convert';

import 'package:serviciosweb/global/environment.dart';
import 'package:serviciosweb/models/trababajador.dart';
import 'package:http/http.dart' as http;

class TrabajadorService {
  registrarTrabajador(Trabajador trabajador) async {
    final res = await http.post('${Environment.apiUrl}/usuarios',
        body: trabajadorToJson(trabajador),
        headers: {'Content-Type': 'application/json'});

    if (res.statusCode == 200) {
      // json.decode(res.body);
      final respData = json.decode(res.body);

      return respData['trabajador']['_id'];
    }
  }

  Future registrar(Trabajador trabajador, String password) async {
    final data = {...trabajador.toJson(), 'password': password};

    final res = await http.post('${Environment.apiUrl}/usuarios',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (res.statusCode == 200) {
      return true;
    } else {
      // final respBody = jsonDecode(res.body);
      final respData = json.decode(res.body);
      return respData['trabajador']['_id'];
    }
  }

// testear porque no retorna falsto
  Future validarEmail(String email) async {
    final res = await http.get('${Environment.apiUrl}/usuarios/$email');

    if (res.statusCode == 200) {
      final respData = json.decode(res.body);
      var esValida = respData['ok'];
      return esValida;
    } else {
      final respData = json.decode(res.body);
      var esValida = respData['ok'];
      return esValida;
    }
  }
}

// validar gmail existente

// trabajar con la imagen en firebase
