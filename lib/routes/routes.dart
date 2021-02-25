import 'package:flutter/material.dart';
import 'package:serviciosweb/pages/registerTrabajador_page.dart';
import 'package:serviciosweb/pages/trabajador_servicio_page.dart';
import 'package:serviciosweb/pages/welcome_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'trabajador_servicio': (_) => TrabajadorServicioPage(),
  'register_trabajador': (_) => RegisterTrabajadorPage(),
  'welcome': (_) => WelcomePage(),
};
