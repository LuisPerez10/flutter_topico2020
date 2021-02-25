import 'dart:convert';

import 'package:serviciosweb/global/environment.dart';

TrabajadorServicio trabajadorServicioFromJson(String str) =>
    TrabajadorServicio.fromJson(json.decode(str));

String trabajadorServicioToJson(TrabajadorServicio data) =>
    json.encode(data.toJson());

class TrabajadorServicio {
  TrabajadorServicio({this.servicio, this.nombre, this.horarios, this.dias});

  String servicio;
  String nombre;
  List<String> horarios;
  List<String> dias;

  factory TrabajadorServicio.fromJson(Map<String, dynamic> json) =>
      TrabajadorServicio(
          servicio: json["servicio"],
          nombre: json["nombre"],
          horarios: json["horarios"],
          dias: json["dias"]);

  Map<String, dynamic> toJson() => {
        "servicio": servicio,
        "nombre": nombre,
        "horarios": horarios,
        "dias": dias
      };
}
