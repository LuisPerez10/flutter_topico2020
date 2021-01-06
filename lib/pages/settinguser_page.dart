import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:serviciosweb/models/usuario.dart';
import 'package:serviciosweb/services/auth_service.dart';
import 'package:serviciosweb/services/upload_service.dart';

class SettingUserPage extends StatefulWidget {
  SettingUserPage({Key key}) : super(key: key);

  @override
  _SettingUserPageState createState() => _SettingUserPageState();
}

class _SettingUserPageState extends State<SettingUserPage> {
  bool _dark;
  PickedFile foto;
  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final fileUploadService = Provider.of<FileUploadService>(context);

    Usuario usuario = authService.usuario;
    return Scaffold(
      backgroundColor: _dark ? null : Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(color: _dark ? Colors.white : Colors.black),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.blue,
                  child: ListTile(
                    onTap: () {
                      _seleccionarFoto().then((_) {
                        if (foto != null) {
                          fileUploadService
                              .actualizarFoto(foto, usuario.uid)
                              .then((img) =>
                                  {usuario.img = img, setState(() {})});
                        }
                      });
                    },
                    title: Text(
                      usuario.nombre,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(usuario.imagenUrl),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.lock_outline,
                          color: Colors.blue,
                        ),
                        title: Text("Cambiar Contraseña"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          //open change password
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 00,
            left: 00,
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.powerOff,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
                AuthService.deleteToken();
                // authService.logout();
              },
            ),
          )
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  Widget addImage() {
    return IconButton(
      icon: Icon(Icons.image),
      color: Colors.blue,
      onPressed: _seleccionarFoto,
    );
  }

  Future _seleccionarFoto() async {
    await _procesarImagen(ImageSource.gallery);
  }

  _procesarImagen(ImageSource origen) async {
    final ImagePicker _picker = ImagePicker();

    foto = await _picker.getImage(source: origen);
    if (foto == null) {
      print('foto nula');
    }
    print('foto cargada');

    setState(() {});
  }
}
