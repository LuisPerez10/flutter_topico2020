import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:serviciosweb/bloc/trabajador_bloc.dart';
import 'package:serviciosweb/bloc/trabajador_servicios_bloc.dart';
import 'package:serviciosweb/models/foto.dart';
import 'package:serviciosweb/models/trababajador.dart';
import 'package:serviciosweb/models/user_register.dart';
import 'package:serviciosweb/pages/trabajador_servicio_page.dart';
import 'package:serviciosweb/pages/vistaForm_page.dart';
import 'package:serviciosweb/services/upload_service.dart';
import 'package:serviciosweb/widgets/list_view_widget.dart';

class RegisterTrabajadorPage extends StatefulWidget {
  RegisterTrabajadorPage({Key key}) : super(key: key);

  @override
  _RegisterTrabajadorPageState createState() => _RegisterTrabajadorPageState();

  static _RegisterTrabajadorPageState of(BuildContext context) =>
      context.findAncestorStateOfType<_RegisterTrabajadorPageState>();
}

class _RegisterTrabajadorPageState extends State<RegisterTrabajadorPage> {
  VistaFormPage vistaForm = VistaFormPage();
  TrabajadorServicioPage trabajadorServicioPage = TrabajadorServicioPage();

  List<Step> steps;
  int currentStep = 0;
  bool complete = false;
  Trabajador trabajador = Trabajador();
  UserRegister userRegister = UserRegister();
  Foto foto = Foto();
  StepperType stepperType = StepperType.horizontal;

  TrabajadorServiciosBloc trabajadorServiciosBloc = TrabajadorServiciosBloc();
  final trabajadorBloc = TrabajadorBloc();
  FileUploadService fileuploadService = FileUploadService();

  switchStepType() {
    setState(() => stepperType == StepperType.horizontal
        ? stepperType = StepperType.vertical
        : stepperType = StepperType.horizontal);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    trabajadorServiciosBloc =
        Provider.of<TrabajadorServiciosBloc>(context, listen: false);
    steps = crearSteps(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          complete
              ? Expanded(
                  child: Center(
                    child: AlertDialog(
                      title: new Text("Perfil Creado"),
                      content: new Text(
                        "Tada!",
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            // setState(() => complete = false);
                            setState(() {});

                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => NewPage()));

                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             RegisterTrabajadorPage()));

                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                'register_trabajador',
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Stepper(
                    type: stepperType,
                    steps: steps,
                    controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                      return Row(
                        children: [
                          Container(
                            child: FlatButton(
                              child: Text(
                                "Atras",
                                style: TextStyle(color: Colors.grey),
                              ),
                              onPressed: onStepCancel,
                            ),
                          ),
                          Container(
                            color:
                                !vistaForm.validate ? Colors.grey : Colors.blue,
                            child: FlatButton(
                              child: Text(
                                "Siguiente",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: !vistaForm.validate
                                  ? null
                                  : () => {
                                        print(trabajador.toJson()),
                                        onStepContinue(),
                                      },
                            ),
                          )
                        ],
                      );
                    },
                    currentStep: currentStep,
                    onStepContinue: next,
                    // onStepTapped: (step) => goTo(step),
                    onStepCancel: cancel,
                  ),
                ),
        ],
      ),
      drawer: Drawer(
        // elevation: 10,
        child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: ListViewWidget()),
      ),
      // Scaffold
      floatingActionButton: botonesFlotantes(),
    );
  }

  next() async {
    bool estaValidado;
    switch (currentStep) {
      case 0:
        estaValidado = vistaForm.formKey.currentState.validate();

        estaValidado ? vistaForm.formKey.currentState.save() : null;

        break;
      case 1:
        estaValidado = trabajadorServicioPage.validar;
        if (estaValidado) {
          print('antes esperando');
          await registrarTrabajador(context);
          print('esperando');
        }
        break;
      default:
        estaValidado = false;
    }
    print('es valido');
    print(estaValidado);
    if (estaValidado) {
      if (currentStep + 1 != steps.length) {
        goTo(currentStep + 1);
      } else {
        setState(() {
          complete = true;
        });
      }
    }
  }
  // crear selecccionar Categoria Servicios y horarios

  Widget botonesFlotantes() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 30.0,
        ),
        Visibility(
          visible: false,
          child: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            onPressed: () {
              cancel();
            },
            backgroundColor: false ? Colors.blue : Colors.grey[350],
            splashColor: Colors.red,
            foregroundColor: Colors.grey[100],
          ),
        ),
        Expanded(child: SizedBox()),
        Visibility(
          visible: true,
          child: FloatingActionButton(
              child: Icon(Icons.list_alt),
              onPressed: () {
                switchStepType();
              }),
        ),
        SizedBox(
          width: 5.0,
        ),
        Visibility(
          visible: false,
          child: FloatingActionButton(
            child: Icon(Icons.arrow_forward),
            onPressed: () {
              next();
            },
          ),
        ),
      ],
    );
  }

  currentStepState(int step) {
    if (currentStep < step) {
      return StepState.indexed;
    } else if (currentStep == step) {
      return StepState.editing;
    } else {
      return StepState.complete;
    }
  }

  List<Step> crearSteps([BuildContext context]) {
    return [
      Step(
        title: Text('Trabajador'),
        isActive: currentStep >= 0,
        state: currentStepState(0),
        content: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            vistaForm,
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      Step(
          isActive: currentStep >= 1,
          state: currentStepState(1),
          title: Text('Servicios'),
          content: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.symmetric(horizontal: 0),
            // color: Colors.green,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: trabajadorServicioPage),
                SizedBox(height: 10.0),
              ],
            ),
          ))
    ];
  }

  registrarTrabajador(BuildContext context) async {
    print('antes accion');

    // trabajadorServiciosBloc.registrarTrabajadorServicio();
    // trabajadorBloc.registrarTrabajado();
    trabajador.img = await fileuploadService.subirImagen(foto.value);

    await trabajadorBloc.registrarTrabajador(trabajador, userRegister.password);

    print('await');
    await trabajadorServiciosBloc
        .registrarTrabajadorServicio(trabajadorBloc.getTrabajador);

    //
    print('despues accion');
  }
}
