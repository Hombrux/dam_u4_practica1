import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class BuscarBitacora extends StatefulWidget {
  const BuscarBitacora({Key? key}) : super(key: key);

  @override
  State<BuscarBitacora> createState() => _BuscarBitacoraState();
}

class _BuscarBitacoraState extends State<BuscarBitacora> {
  TextEditingController fechaController = TextEditingController(text: '');

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
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar'), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            TextField(
              controller: fechaController,
              onTap: () => _selectDate(context, fechaController),
              decoration: const InputDecoration(labelText: 'FECHA',),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () async{
              await Navigator.pushNamed(context, '/verBfecha',arguments: {
              "fecha" : fechaController.text
              });
              //setState(() {});
            }, child: const Text('Buscar bitacora')),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: () async{
              await Navigator.pushNamed(context, '/vehiculoUso');
              setState(() {});
            }, child: const Text('Ver Vehiculos en uso'))
          ],
        ),
      ),
    );
  }
}
