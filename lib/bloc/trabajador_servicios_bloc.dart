import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:serviciosweb/models/trabajador_servicio.dart';
import 'package:serviciosweb/services/trabajador_servicios_services.dart';

class TrabajadorServiciosBloc {
  final trabajadorServicios = List<TrabajadorServicio>();
  String idtrabajador;

  set setTrabajador(String cod) => idtrabajador = cod;
  final _trabajadorServiciosController =
      new BehaviorSubject<List<TrabajadorServicio>>();

  final _trabajadorServiciosServices = TrabajadorServiciosService();

  Stream<List<TrabajadorServicio>> get trabajadorServiciosStream =>
      _trabajadorServiciosController.stream;

  void guardarTrabajadorServicio(TrabajadorServicio trabajadorServicio) {
    trabajadorServicios.add(trabajadorServicio);
    _trabajadorServiciosController.sink.add(trabajadorServicios);
  }

  Future registrarTrabajadorServicio(String codTrabajador) async {
    print(trabajadorServicios);
    await _trabajadorServiciosServices.guardarTrabajadorServicio(
        trabajadorServicios, codTrabajador);
  }

  List<TrabajadorServicio> getTrabajadorServicio() {
    return this.trabajadorServicios;
  }

  borrarTrabajadorServicioId(index) {
    this.trabajadorServicios.removeAt(index);
  }

  dispose() {
    _trabajadorServiciosController?.close();
  }
}
