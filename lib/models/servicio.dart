import 'dart:convert';

import 'package:serviciosweb/global/environment.dart';

Servicio servicioFromJson(String str) => Servicio.fromJson(json.decode(str));

String servicioToJson(Servicio data) => json.encode(data.toJson());

class Servicio {
  Servicio({
    this.id,
    this.nombre,
    this.estado,
  });
  String id;
  String nombre;
  String estado;

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        id: json["id"],
        nombre: json["nombre"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "estado": estado,
      };
}
