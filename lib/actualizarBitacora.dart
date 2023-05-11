import 'package:dam_u4_practica1/firestoredb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ActualizarBitacora extends StatefulWidget {
  const ActualizarBitacora({Key? key}) : super(key: key);

  @override
  State<ActualizarBitacora> createState() => _ActualizarBitacoraState();
}

class _ActualizarBitacoraState extends State<ActualizarBitacora> {
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
    TextEditingController verificoController = TextEditingController(text:arguments['verifico']);
    TextEditingController fechaVController = TextEditingController(text:arguments['fechaverificacion']);

    return Scaffold(appBar: AppBar(title:const Text('Actualizar Bitacora'),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: ListView(
          children: [
            TextField(controller: verificoController,decoration: const InputDecoration(labelText: 'VERIFICO',)),
            const SizedBox(height: 5,),
            TextField(
              controller: fechaVController,
              onTap: () => _selectDate(context, fechaVController),
              decoration: const InputDecoration(labelText: 'FECHA VERIFiCACION',),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () async{
              Map<String,dynamic> bitacora = {
                "fecha": arguments['fecha'],
                "evento":arguments['evento'],
                "recursos":arguments['recursos'],
                "verifico":verificoController.text,
                "fechaverificacion":fechaVController.text
              };
              await actualizarBitacora(arguments['aid'],arguments['bid'],bitacora).then((_){
                Navigator.pop(context);
                Navigator.pop(context);
              });
            }, child: const Text('Guardar'))
          ],
        ),
      ),
    );
  }
}
