import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosweb/helpers/validar.dart';
import 'package:serviciosweb/models/horario.dart';
import 'package:serviciosweb/services/horario_service.dart';
import 'package:serviciosweb/utils/sysUtils.dart';
import 'package:serviciosweb/widgets/boton_principal.dart';
import 'package:serviciosweb/widgets/custom_loading.dart';

class CheckBoxWidget extends StatefulWidget {
  final Function(List<String>, List<String>) callback;
  const CheckBoxWidget({Key key, this.callback}) : super(key: key);
  // requiere trabajador servicios
  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  final Map<String, bool> diasChecked = {
    'Lunes': false,
    'Marte': false,
    'Mierc': false,
    'Jueve': false,
    'Viern': false,
    'Sabad': false,
    'Domin': false,
  };
  Map<String, bool> horarioChecked = {};
  List<dynamic> diasSelected = [];
  List<dynamic> horarioSelected = [];

  List<String> getItems(Map<String, bool> mapItemsSelected) {
    // bool validar = false;
    List<String> items = [];
    mapItemsSelected.forEach((key, value) {
      if (value == true) {
        items.add(key);
        // validar = true;
      }
    });

    print(items);
    return items;
    // horariosSelected.clear();
  }

  @override
  Widget build(BuildContext context) {
    final horarios = Provider.of<HorarioService>(context);

    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 20, bottom: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          'Dias laborales',
          style: TextStyle(
              fontSize: 14, color: Color.fromARGB(255, 188, 193, 210)),
        ),
      ),

      //=====================

      Container(
          child: Wrap(
        alignment: WrapAlignment.start,
        children: diasChecked.keys.map((String key) {
          return Container(
            // padding: EdgeInsets.all(0),
            // margin: EdgeInsets.all(0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 246, 246, 246),
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  margin:
                      EdgeInsets.only(left: 0, right: 5, top: 10, bottom: 10),
                  child: Text('$key', style: TextStyle(fontSize: 11)),
                ),
                Positioned(
                    bottom: 12,
                    right: -15,
                    child: new Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: diasChecked[key],
                      onChanged: (bool value) {
                        setState(() {
                          diasChecked[key] = value;
                        });
                      },
                    )),
              ],
            ),
          );
        }).toList(),
      )),
      Container(
        padding: EdgeInsets.only(left: 20, bottom: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          'Mis Horarios',
          style: TextStyle(
              fontSize: 14, color: Color.fromARGB(255, 188, 193, 210)),
        ),
      ),

      //  crear nuevo widget para horarios

      Container(
        height: 200,
        child: FutureBuilder(
          future: horarios.obtenerHorarios(),
          builder: (context, AsyncSnapshot<List<Horario>> snapshot) {
            if (snapshot.hasData) {
              var horarios = snapshot.data;
              cargarHorarioStatico(horarios);
              return ListView.builder(
                itemCount: horarios.length,
                itemBuilder: (context, i) {
                  var key = horarioChecked.keys.elementAt(i);
                  return Container(
                    child: CheckboxListTile(
                      title: Text(horarios[i].nombre),
                      subtitle: Text(
                          '${horarios[i].horaInicio} - ${horarios[i].horaFin}'),
                      value: horarioChecked[key],
                      activeColor: Theme.of(context).primaryColor,
                      checkColor: Colors.white,
                      onChanged: (bool value) {
                        setState(() {
                          horarioChecked[key] = value;
                          print(horarioChecked.toString());
                          // diasChecked['id'] = value;
                        });
                      },
                    ),
                  );
                },
              );
            } else {
              return CurstomLoading();
            }
          },
        ),
      ),

      BotonPrincipal(
        text: 'guardar',
        onPressed: isValidItemsSelected()
            ? () {
                print('onpreseddd');
                widget.callback(this.horarioSelected, this.diasSelected);
                Navigator.of(context).pop();
              }
            : null,
      ),
    ]);
  }

  void cargarHorarioStatico(List<dynamic> horarios) {
    if (horarioChecked.length == 0) {
      horarios.forEach((customer) => horarioChecked[customer.id] = false);
    }
  }

  bool isValidItemsSelected() {
    this.horarioSelected = getItems(horarioChecked);
    this.diasSelected = getItems(diasChecked);
    bool resp = (!isEmpty(this.horarioSelected) && !isEmpty(this.diasSelected));
    print(resp);
    return resp;
  }
}
