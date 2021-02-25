import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosweb/routes/routes.dart';
import 'package:serviciosweb/services/auth_service.dart';
import 'package:serviciosweb/services/categoria_services.dart';
import 'package:serviciosweb/services/horario_service.dart';
import 'package:serviciosweb/services/servicio_services.dart';
import 'package:serviciosweb/services/trabajador_servicios_services.dart';
import 'package:serviciosweb/services/trabajdor_service.dart';
import 'package:serviciosweb/services/upload_service.dart';
import 'package:serviciosweb/bloc/trabajador_bloc.dart';

import 'bloc/trabajador_servicios_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => FileUploadService()),
          Provider(create: (_) => ServicioService()),
          Provider(create: (_) => HorarioService()),
          Provider(create: (_) => CategoriaService()),
          Provider(create: (_) => TrabajadorServiciosService()),
          Provider(create: (_) => TrabajadorServiciosBloc()),
          Provider(create: (_) => TrabajadorService()),
          Provider(create: (_) => TrabajadorBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tarea IV',
          initialRoute: 'register_trabajador',
          // initialRoute: 'trabajador_servicio',
          routes: appRoutes,
          theme: ThemeData(primaryColor: Color.fromARGB(255, 252, 96, 17)),
        ));
  }
}
