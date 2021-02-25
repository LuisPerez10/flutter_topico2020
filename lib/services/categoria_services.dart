import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:serviciosweb/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:serviciosweb/models/categoria.dart';

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

class CategoriaService {
  final _categoriasController = new BehaviorSubject<List<Categoria>>();

  Stream<List<Categoria>> get obtenerCategorias => _categoriasController.stream;

  CategoriaService() {
    print('crea instancia Categoria');
    cargarCategoria();
    // this.cargarCategoria.listen(
    //     (categoriasList) => this._categoriasController.add(categoriasList));
  }

  void cargarCategoria() async {
    final url = '${Environment.apiUrl}/categorias';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    List<Categoria> categorias = new List();

    decodedData['categorias'].forEach((prod) {
      final prodTemp = Categoria.fromJson(prod);
      prodTemp.id = prod['_id'];
      categorias.add(prodTemp);
    });
    // await Future.delayed(Duration(seconds: 5));

    _categoriasController.sink.add(categorias);
  }

  dispose() {
    _categoriasController?.close();
  }
}
