// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:serviciosweb/global/environment.dart';

UserRegister userFromJson(String str) =>
    UserRegister.fromJson(json.decode(str));

String userToJson(UserRegister data) => json.encode(data.toJson());

final base_url = Environment.apiUrl;

class UserRegister {
  UserRegister({this.nombre, this.email, this.password});

  String nombre;
  String email;
  String password;

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        nombre: json["nombre"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "email": email,
        "password": password,
      };
}
