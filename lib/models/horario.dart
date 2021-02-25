import 'dart:convert';

import 'package:serviciosweb/global/environment.dart';

Horario categoriaFromJson(String str) => Horario.fromJson(json.decode(str));

String categoriaToJson(Horario data) => json.encode(data.toJson());

class Horario {
  Horario({
    this.id,
    this.nombre,
    this.horaInicio,
    this.horaFin,
  });
  String id;
  String nombre;
  String horaInicio;
  String horaFin;

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        id: json["id"],
        nombre: json["nombre"],
        horaInicio: json["horaInicio"],
        horaFin: json["horaFin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "horaInicio": horaInicio,
        "horaFin": horaFin,
      };
}
