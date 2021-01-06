import 'package:flutter/material.dart';
import 'package:serviciosweb/pages/loading_page.dart';
import 'package:serviciosweb/pages/login_page.dart';
import 'package:serviciosweb/pages/register_page.dart';
import 'package:serviciosweb/pages/settinguser_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
  'settinguser': (_) => SettingUserPage()
};
