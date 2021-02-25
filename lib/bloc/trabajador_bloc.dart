import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:serviciosweb/models/trababajador.dart';
import 'package:serviciosweb/models/trabajador_servicio.dart';
import 'package:serviciosweb/models/user_register.dart';
import 'package:serviciosweb/services/trabajador_servicios_services.dart';
import 'package:serviciosweb/services/trabajdor_service.dart';

class TrabajadorBloc {
  String trabajador;
  final _trabajadorService = TrabajadorService();

  String get getTrabajador => trabajador;
  // Future registrarTrabajador(Trabajador trabajador) async {
  //   this.trabajador = await _trabajadorService.registrarTrabajador(trabajador);
  // }
  Future registrarTrabajador(Trabajador trabajador, String password) async {
    this.trabajador = await _trabajadorService.registrar(trabajador, password);
  }
}
