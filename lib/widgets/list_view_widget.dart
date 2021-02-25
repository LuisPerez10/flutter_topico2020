import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosweb/bloc/trabajador_servicios_bloc.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trabajadorServiciosBloc =
        Provider.of<TrabajadorServiciosBloc>(context, listen: false);
    final trabajadorServicio = trabajadorServiciosBloc.getTrabajadorServicio();
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: trabajadorServicio.length,
        itemBuilder: (_, i) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              Provider.of<TrabajadorServiciosBloc>(context, listen: false)
                  .borrarTrabajadorServicioId(i);
            },
            child: ListTile(
              leading: Icon(Icons.access_alarm,
                  color: Theme.of(context).primaryColor),
              title: Text(trabajadorServicio[i].nombre),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
