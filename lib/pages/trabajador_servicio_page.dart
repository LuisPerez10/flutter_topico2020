import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosweb/bloc/trabajador_servicios_bloc.dart';
import 'package:serviciosweb/models/categoria.dart';
import 'package:serviciosweb/models/servicio.dart';
import 'package:serviciosweb/models/trabajador_servicio.dart';
import 'package:serviciosweb/services/categoria_services.dart';
import 'package:serviciosweb/services/servicio_services.dart';
import 'package:serviciosweb/utils/sysUtils.dart';
import 'package:serviciosweb/widgets/checkbox_widget.dart';
import 'package:serviciosweb/widgets/grid_widget.dart';
import 'package:serviciosweb/widgets/popover_widget.dart';

class TrabajadorServicioPage extends StatefulWidget {
  bool validar = false;
  TrabajadorServicioPage({Key key}) : super(key: key);
  @override
  _TrabajadorServicioPageState createState() => _TrabajadorServicioPageState();
}

class _TrabajadorServicioPageState extends State<TrabajadorServicioPage> {
  int currentIndex = 0;

  Categoria categoria = Categoria();
  Servicio servicio = Servicio();
  TrabajadorServicio trabajadorServicio = TrabajadorServicio();
  TrabajadorServiciosBloc trabajadorServiciosBloc;

  nextPage() {
    currentIndex++;
    setState(() {});
  }

  previousPage() {
    currentIndex--;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    trabajadorServiciosBloc = Provider.of<TrabajadorServiciosBloc>(context);
    return Container(
      height: MediaQuery.of(context).size.height - 230.0,
      width: double.infinity,
      child: callPage(currentIndex),
    );
  }

  callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        // final categorias = CategoriaService();
        final categorias = Provider.of<CategoriaService>(context);
        // Provider.of<CategoriaService>(context);
        return Column(
          children: [
            Row(
              children: [
                Container(
                    child: Text(
                  'Categorias Disponibles',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
                // Expanded(),
                Expanded(child: SizedBox()),
                // verServicios(),
                GestureDetector(
                  onTap: () {
                    //llamar a abrir el drawe
                    print('object');
                    Scaffold.of(context).openDrawer();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Mis Servicios',
                            style: TextStyle(
                                color: Color.fromARGB(255, 120, 120, 120)),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
                child: new GridWidget(Key('1'), categorias.obtenerCategorias,
                    (dynamic model) {
              categoria = model;
              print('servicio Seleccionado $categoria.nombre');
              nextPage();
            })),
          ],
        );
        break;
      case 1:
        final servicios =
            ServicioService(); //Provider.of<ServicioService>(context);
        servicios.cargarServicioPorIdCategoria(categoria.id);
        return Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: previousPage,
                    child: Container(
                        child: Icon(
                      Icons.arrow_back,
                    ))),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: previousPage,
                  child: Container(
                      child: Text(
                    '${categoria.nombre} / ',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
                ),
                Container(
                    child: Text(
                  'Servicios disponibles',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
              ],
            ),
            Expanded(
              flex: 4,
              child: new GridWidget(Key('2'), servicios.obtenerServicios,
                  (dynamic model) {
                servicio = model;
                _handleFABPressed();
                // agregarHorario(context);
                print('object');
              }),
            ),
          ],
        );
        break;
      default:
    }
  }

  validarTrabajadorServicio() {
    bool valida = !isEmpty(trabajadorServiciosBloc.trabajadorServicios);
    widget.validar = valida;
  }

  void _handleFABPressed() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: Column(
            children: [
              CheckBoxWidget(
                  callback: (List<String> model1, List<String> model2) {
                trabajadorServicio = TrabajadorServicio();
                trabajadorServicio.servicio = servicio.id;
                trabajadorServicio.nombre = servicio.nombre;
                trabajadorServicio.horarios = model1;
                trabajadorServicio.dias = model2;
                guardarTrabajadorServicio();
              }),
            ],
          ),
        );
      },
    );
  }

  void guardarTrabajadorServicio() {
    trabajadorServiciosBloc.guardarTrabajadorServicio(trabajadorServicio);
    validarTrabajadorServicio();
  }

  verServicios() {}
}
