import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';
import 'package:serviciosweb/global/environment.dart';

import 'package:serviciosweb/models/trabajador_servicio.dart';

class TrabajadorServiciosService {
  // Singleton trafficService

  // final String _url = 'https://proyectotopico-d46f5.firebaseio.com/';
  // final _prefs = new PreferenciasUsuario();

  Future<bool> guardarTrabajadorServicio(
      List<TrabajadorServicio> trabajadorServicios,
      String codTrabajador) async {
    final url = '${Environment.apiUrl}/trabajadorservicios/$codTrabajador';
    var data = '{"serviciosList":[';
    for (var item in trabajadorServicios) {
      var items = trabajadorServicioToJson(item);
      data += items;
    }
    data += "]}";
    // final resp = await http.post('${Environment.apiUrl}/trabajadorservicios',
    //     body: data, headers: {'Content-Type': 'application/json'});
    final resp = await http
        .post(url, body: data, headers: {'Content-Type': 'application/json'});

    final decodedData = json.decode(resp.body);
    print(decodedData);
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
