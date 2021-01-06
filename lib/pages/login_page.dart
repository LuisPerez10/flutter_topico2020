import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:serviciosweb/helpers/mostrar_alerta.dart';
import 'package:serviciosweb/services/auth_service.dart';
import 'package:serviciosweb/widgets/boton_azul.dart';
import 'package:serviciosweb/widgets/custom_input.dart';
import 'package:serviciosweb/widgets/labels.dart';
import 'package:serviciosweb/widgets/logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(titulo: 'TaskIV'),
                  _Form(),
                  Labels(
                    ruta: 'register',
                    titulo: '¿No tienes cuenta?',
                    subTitulo: 'Crea una ahora!',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Ingrese',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginOk) {
                      Navigator.pushReplacementNamed(context, 'settinguser');
                    } else {
                      mostrarAlerta(context, 'Login incorrecto',
                          'Revise sus Credenciales');
                    }
                  },
          )
        ],
      ),
    );
  }
}
