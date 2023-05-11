import 'package:dam_u4_practica1/firestoredb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart' show CupertinoDatePicker;

class InsertarBitacora extends StatefulWidget {
  const InsertarBitacora({Key? key}) : super(key: key);

  @override
  State<InsertarBitacora> createState() => _InsertarBitacoraState();
}

class _InsertarBitacoraState extends State<InsertarBitacora> {
  TextEditingController fechaController = TextEditingController(text: '');
  TextEditingController eventoController = TextEditingController(text: '');
  TextEditingController recursosController = TextEditingController(text: '');
  TextEditingController verificoController = TextEditingController(text: '');
  TextEditingController fechaVController = TextEditingController(text: '');

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(title: const Text('Bitacora'),),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: ListView(
          children: [
            TextField(
              controller: fechaController,
              onTap: () => _selectDate(context, fechaController),
              decoration: const InputDecoration(labelText: 'FECHA',),
            ),
            //TextField(controller: fechaController,keyboardType: TextInputType.datetime,decoration: const InputDecoration(labelText: 'FECHA',)),
            const SizedBox(height: 5,),
            TextField(controller: eventoController,decoration: const InputDecoration(labelText: 'EVENTO',)),
            const SizedBox(height: 5,),
            TextField(controller: recursosController,decoration: const InputDecoration(labelText: 'RECURSOS',)),
            const SizedBox(height: 5,),
            TextField(controller: verificoController,decoration: const InputDecoration(labelText: 'VERIFICO',)),
            const SizedBox(height: 5,),
            TextField(
              controller: fechaVController,
              onTap: () => _selectDate(context, fechaVController),
              decoration: const InputDecoration(labelText: 'FECHA VERIFiCACION',),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () async{
              Map<String, dynamic> bitacora = {
                "fecha": fechaController.text,
                "evento":eventoController.text,
                "recursos":recursosController.text,
                "verifico":verificoController.text,
                "fechaverificacion":fechaVController.text
              };
              await agregarBitacora(arguments['aid'],bitacora).then((_){
                Navigator.pop(context);
              });
            }, child: const Text('Guardar'))
          ],
        ),
      ),
    );
}
}
