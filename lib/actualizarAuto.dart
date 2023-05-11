import 'package:dam_u4_practica1/firestoredb.dart';
import 'package:flutter/material.dart';
class ActualizarAuto extends StatefulWidget {
  const ActualizarAuto({Key? key}) : super(key: key);

  @override
  State<ActualizarAuto> createState() => _ActualizarAutoState();
}

class _ActualizarAutoState extends State<ActualizarAuto> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    TextEditingController placaController = TextEditingController(text: arguments['placa']);
    TextEditingController tipoController = TextEditingController(text: arguments['tipo']);
    TextEditingController numserieController = TextEditingController(text: arguments['numeroserie']);
    TextEditingController combustibleController = TextEditingController(text: arguments['combustible']);
    TextEditingController tanqueController = TextEditingController(text: arguments['tanque'].toString());
    TextEditingController trabajadorController = TextEditingController(text: arguments['trabajador']);
    TextEditingController deptoController = TextEditingController(text: arguments['depto']);
    TextEditingController resguardoController = TextEditingController(text: arguments['resguardadopor']);
    return Scaffold(
      appBar: AppBar(title: const Text('Modificar auto'),),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: ListView(
        children: [
          TextField(controller: placaController,decoration: const InputDecoration(labelText: 'PLACA',)),
          const SizedBox(height: 5,),
          TextField(controller: tipoController,decoration: const InputDecoration(labelText: 'TIPO',)),
          const SizedBox(height: 5,),
          TextField(controller: numserieController,decoration: const InputDecoration(labelText: 'NUMERO DE SERIE',)),
          const SizedBox(height: 5,),
          TextField(controller: combustibleController,decoration: const InputDecoration(labelText: 'COMBUSTIBLE',)),
          const SizedBox(height: 5,),
          TextField(controller: tanqueController,decoration: const InputDecoration(labelText: 'TANQUE',)),
          const SizedBox(height: 5,),
          TextField(controller: trabajadorController,decoration: const InputDecoration(labelText: 'TRABAJADOR',)),
          const SizedBox(height: 5,),
          TextField(controller: deptoController,decoration: const InputDecoration(labelText: 'DEPARTAMENTO',)),
          const SizedBox(height: 5,),
          TextField(controller: resguardoController,decoration: const InputDecoration(labelText: 'RESGUARDADO POR',)),
          const SizedBox(height:10,),
          ElevatedButton(onPressed: () async {
            Map<String, dynamic> auto = {
              "placa": placaController.text,
              "tipo": tipoController.text,
              "numeroserie": numserieController.text,
              "combustible": combustibleController.text,
              "tanque": tanqueController.text,
              "trabajador": trabajadorController.text,
              "depto": deptoController.text,
              "resguardadopor": resguardoController.text
            };
            await actualizarVehiculo(arguments['aid'],auto).then((_) {
              Navigator.pop(context);
            });
          },
          child: const Text('Actualizar'),
        )
      ],
    )),
    );
  }
}
