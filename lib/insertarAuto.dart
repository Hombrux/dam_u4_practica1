import 'package:dam_u4_practica1/firestoredb.dart';
import 'package:flutter/material.dart';
class InsertarAuto extends StatefulWidget {
  const InsertarAuto({Key? key}) : super(key: key);

  @override
  State<InsertarAuto> createState() => _InsertarAutoState();
}

class _InsertarAutoState extends State<InsertarAuto> {
  TextEditingController placaController = TextEditingController(text: '');
  TextEditingController tipoController = TextEditingController(text: '');
  TextEditingController numserieController = TextEditingController(text: '');
  TextEditingController combustibleController = TextEditingController(text: '');
  TextEditingController tanqueController = TextEditingController(text: '');
  TextEditingController trabajadorController = TextEditingController(text: '');
  TextEditingController deptoController = TextEditingController(text: '');
  TextEditingController resguardoController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Auto'),),
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
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () async{
              Map<String, dynamic> auto = {
                "placa": placaController.text,
                "tipo":tipoController.text,
                "numeroserie":numserieController.text,
                "combustible":combustibleController.text,
                "tanque":tanqueController.text,
                "trabajador":trabajadorController.text,
                "depto":deptoController.text,
                "resguardadopor":resguardoController.text
                  };
              await agregarVehiculo(auto).then((_){
                Navigator.pop(context);
              });
            }, child: const Text('Guardar'))
          ],
        ),
      ),
    );
  }
}
