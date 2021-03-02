import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:serviciosweb/widgets/boton_principal.dart';
import 'package:serviciosweb/widgets/customClipper.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).primaryColor;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(children: [
          _crearFondo(context),
          _crearLogo(size),
          // _nombreApp(size, color, context),
        ]),
      ),
    );
  }

  Positioned _nombreApp(Size size, Color color, BuildContext context) {
    return Positioned(
      top: size.height * .5,
      child: Container(
        width: size.width,
        height: size.height * .5,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              margin: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Golden',
                    style: TextStyle(
                      fontSize: 34,
                      fontFamily: "Cabin",
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text('Hands',
                      style: TextStyle(
                          fontSize: 34,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 74, 75, 77))),
                ],
              ),
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.all(15),
              // fakta poner color y botones de navegacion
              alignment: Alignment.center,
              // color: Colors.red,
              child: Text(
                'SERVICIOS DE TRABAJOS',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 124, 125, 126),
                    fontFamily: 'Metropolis',
                    fontSize: 10,
                    letterSpacing: 2),
              ),
            ),
            Container(
              width: size.width,
              padding:
                  EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
              alignment: Alignment.center,
              child: Text(
                'Ofrece tus servicios de acuerdo a tu talento y habilidades,  mas de 1000 empleadores esperan por Ti.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.3,
                    color: Color.fromARGB(255, 124, 125, 126),
                    fontFamily: 'Metropolis'),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              width: size.width * .8,
              child: Column(
                children: [
                  BotonPrincipal(text: 'Login', onPressed: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  BotonPrincipal(
                      text: 'Crear una Cuenta',
                      color: Colors.white,
                      textColor: color,
                      onPressed: () {
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context,
                        //     'register_trabajador',
                        //     (Route<dynamic> route) => false);
                        Navigator.pushNamed(context, 'register_trabajador');
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Positioned _crearLogo(Size size) {
    return Positioned(
      child: Container(
          padding: EdgeInsets.only(bottom: 30),
          alignment: Alignment.center,
          width: size.width,
          child: Container(
            color: Colors.white.withOpacity(0),
            width: size.width * 0.3,
            child: Image.asset('assets/logo-main.png'),
          )),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    final size = MediaQuery.of(context).size;

    final circulo = (double w, [double h]) => Container(
        width: w,
        height: h ?? w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(180),
          color: Color.fromARGB(53, 255, 255, 255),
        ));

    var ctsw = size.width / 375;
    var ctsh = size.height * .5 / 382;
    return Container(
      child: CustomPaint(
        painter: _ClipShadowShadowPainter(
            clipper: ClipPainter(),
            shadow: Shadow(
                blurRadius: 15,
                offset: Offset(0, 15),
                color: Color.fromARGB(70, 74, 75, 77))),
        child: ClipPath(
            clipper: ClipPainter(),
            child: Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: color,
              ),
              Positioned(
                  top: -55 * ctsh, left: -62 * ctsw, child: circulo(178)),
              Positioned(top: 77 * ctsh, left: 20 * ctsw, child: circulo(105)),
              Positioned(
                  top: -159 * ctsh, left: 165 * ctsw, child: circulo(289)),
              Positioned(top: 130 * ctsh, left: 223 * ctsw, child: circulo(29)),
              Positioned(top: 118 * ctsh, left: 150 * ctsw, child: circulo(18)),
              Positioned(top: 219 * ctsh, left: 152 * ctsw, child: circulo(13)),
              Positioned(
                  top: 161 * ctsh, left: 288 * ctsw, child: circulo(130)),
              Positioned(top: 328 * ctsh, left: 360 * ctsw, child: circulo(21)),
              Positioned(
                  top: 219 * ctsh, left: -89 * ctsw, child: circulo(232)),
            ])),
      ),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
