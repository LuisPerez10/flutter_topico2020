import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:serviciosweb/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosweb/models/categoria.dart';
import 'package:serviciosweb/models/horario.dart';

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

class HorarioService {
  Future<List<Horario>> obtenerHorarios() async {
    final url = '${Environment.apiUrl}/horarios';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    List<Horario> categorias = new List();

    decodedData['horarios'].forEach((prod) {
      final prodTemp = Horario.fromJson(prod);
      prodTemp.id = prod['_id'];
      categorias.add(prodTemp);
    });

    return categorias;
    // _categoriasController.sink.add(categorias);
  }

  dispose() {
    // _categoriasController?.close();
  }
}
