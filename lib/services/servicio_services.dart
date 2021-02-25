import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:serviciosweb/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosweb/models/servicio.dart';

List<dynamic> CATEGORIAS = [
  'Cat 1',
  'Cat 2',
  'Cat 3',
  'Cat 4',
  'Cat 5',
  'Cat 6',
  'Cat 7',
  'Cat 8',
  'Cat 9',
  'Cat 1',
  'Cat 10',
  'Cat 12',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 13',
  'Cat 14',
  'Cat 14',
  'Cat 14',
  'Cat 14',
  'Cat 14',
  'Cat 14',
  'Cat 14',
  'Cat 14',
  'Cat 14',
  'Cat 14',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
  'Cat 15',
];

class ServicioService {
  final _serviciosController = new BehaviorSubject<List<Servicio>>();

  Stream<List<Servicio>> get obtenerServicios => _serviciosController.stream;

  ServicioService() {
    print('Intancia Servicio');
  }

  void cargarServicioPorIdCategoria(String idCategoria) async {
    final url = '${Environment.apiUrl}/servicios/$idCategoria';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    List<Servicio> servicios = new List();
    // print(decodedData['servicios']);
    print('servicios');
    decodedData['servicios'].forEach((prod) {
      final prodTemp = Servicio.fromJson(prod);
      prodTemp.id = prod['_id'];
      servicios.add(prodTemp);
    });
    // await Future.delayed(Duration(seconds: 5));
    // servicios = [...CATEGORIAS];
    // print(servicios);
    _serviciosController.sink.add(servicios);
    // return servicios;
  }

  dispose() {
    _serviciosController?.close();
  }
}
