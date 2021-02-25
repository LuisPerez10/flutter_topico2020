import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serviciosweb/models/categoria.dart';
import 'package:serviciosweb/widgets/custom_loading.dart';

class GridWidget extends StatelessWidget {
  final Stream<List<dynamic>> stream;
  final Function(dynamic) callback;
  GridWidget([Key key, this.stream, this.callback]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_crearFondo(context), _itemsGrid()],
    );
  }

  _itemsGrid() {
    return new StreamBuilder(
      stream: this.stream,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          print('Gridview');
          return GridView.builder(
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 17.0,
                crossAxisSpacing: 18.0),
            itemBuilder: (context, i) {
              return _cardTipo2(snapshot.data[i]);
            },
          );
        } else {
          print('cargando');
          return CurstomLoading();
          // return Text('Cargando');
        }
      },
    );
  }

  Widget _cardTipo2(dynamic item) {
    final card = Container(
      // clipBehavior: Clip.antiAlias,

      child: Column(
        children: <Widget>[
          SizedBox(height: 5.0),
          Expanded(
            flex: 6,
            child: FadeInImage(
              image: NetworkImage('https://picsum.photos/200'),
              placeholder: AssetImage('assets/icon-loading.gif'),
              fadeInDuration: Duration(milliseconds: 500),
              width: 60.0,
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
                padding: EdgeInsets.only(
                    left: 5.0, right: 5.0, bottom: 2.0, top: 5.0),
                child: Column(
                  children: [
                    Text(
                      '${item.nombre}',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '45 Servicios',
                      style: TextStyle(
                          fontSize: 9,
                          color: Color.fromARGB(255, 182, 183, 183)),
                    ),
                  ],
                )),
          )
        ],
      ),
    );

    return GestureDetector(
        onTap: () {
          print('print ${item.id}');
          callback(item);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.0),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1.0,
                    spreadRadius: 0.1,
                    offset: Offset(0.0, 1.0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13.0),
            child: card,
          ),
        ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 7, 1, 1.0)
      ])),
    );

    final circulo = (double w, [double h]) => Container(
        width: w,
        height: h ?? w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromARGB(25, 252, 96, 17),
        ));

    final rectangle = Container(
      width: 100.0,
      height: 485.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(38), topRight: Radius.circular(38)),
          color: Theme.of(context).primaryColor),
    );

    return Stack(
      children: <Widget>[
        // fondoModaro,
        // Positioned(top: 80.0, left: 0.0, child: rectangle),
        Positioned(top: 40.0, left: 117.0, child: circulo(114)),
        Positioned(top: 250.0, left: 200.0, child: circulo(76)),
        Positioned(top: 250.0, left: 30.0, child: circulo(89)),
        Positioned(top: 350.0, left: 100.0, child: circulo(151)),
      ],
    );
  }
}
