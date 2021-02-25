import 'dart:convert';

import 'package:serviciosweb/global/environment.dart';

Trabajador trabajadorFromJson(String str) =>
    Trabajador.fromJson(json.decode(str));

String trabajadorToJson(Trabajador data) => json.encode(data.toJson());

final base_url = Environment.apiUrl;

class Trabajador {
  Trabajador({
    this.id,
    this.nombre,
    this.apellido,
    this.celular,
    this.img,
    this.direccion,
    this.email,
    // this.password,
  });

  String id;
  String nombre;
  String apellido;
  String celular;
  String img;
  String direccion;
  String email;
  // String password;

  factory Trabajador.fromJson(Map<String, dynamic> json) => Trabajador(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        celular: json["celular"],
        img: json["img"],
        direccion: json["direccion"],
        email: json["email"],
        // // password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "celular": celular,
        "img": img,
        "direccion": direccion,
        "email": email,
        // // "password": password,
      };

  String get imagenUrl {
    if (this.img == null) {
      return '$base_url/upload/trabajadors/no-image';
    } else if (this.img.contains('https')) {
      return this.img;
    } else if (this.img != null) {
      return '$base_url/upload/trabajadors/${this.img}';
    } else {
      return '$base_url/upload/trabajadors/no-image';
    }
  }
}
