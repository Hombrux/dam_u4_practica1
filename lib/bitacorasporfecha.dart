import 'package:flutter/material.dart';

import 'firestoredb.dart';
class VerBitacorasFecha extends StatefulWidget {
  const VerBitacorasFecha({Key? key}) : super(key: key);

  @override
  State<VerBitacorasFecha> createState() => _VerBitacorasFechaState();
}

class _VerBitacorasFechaState extends State<VerBitacorasFecha> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(title: Text('Bitacora de ${arguments['fecha']}',),centerTitle: true,),
      body: FutureBuilder(
          future: buscarBitacora(arguments['fecha']),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: const Icon(Icons.find_in_page_sharp),
                      title: Text(snapshot.data?[index]['evento'] + " - " + snapshot.data?[index]['recursos']),
                      subtitle: Text((snapshot.data?[index]['fecha'].toString() ?? "") + (" - ${snapshot.data?[index]['fechaverificacion']}" ?? "")),
                      trailing: Text(snapshot.data?[index]['verifico'].toString() ?? ""),
                      onTap: (){
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('¿Quiere actualizar la bitacora ${snapshot.data?[index]['placa']}?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Actualizar'),
                                onPressed: () async{
                                  await Navigator.pushNamed(context,'/actualizarB',arguments:{
                                    "fecha":snapshot.data?[index]['fecha'],
                                    "evento":snapshot.data?[index]['evento'],
                                    "recursos":snapshot.data?[index]['recursos'],
                                    "fechaverificacion": snapshot.data?[index]['fechaverificacion'],
                                    "verifico" : snapshot.data?[index]['verifico'],
                                    "bid":snapshot.data?[index]['bid'],
                                    "aid":snapshot.data?[index]['aid']
                                  });
                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        });
                      },
                    );
                  }
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),);
  }
}
