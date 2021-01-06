import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosweb/routes/routes.dart';
import 'package:serviciosweb/services/auth_service.dart';
import 'package:serviciosweb/services/upload_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => FileUploadService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tarea IV',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
