import 'package:dam_u4_practica1/firestoredb.dart';
import 'package:flutter/material.dart';

class verBitacora extends StatefulWidget {
  const verBitacora({Key? key}) : super(key: key);

  @override
  State<verBitacora> createState() => _verBitacoraState();
}

class _verBitacoraState extends State<verBitacora> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(title: Text('Bitacora de ${arguments['placa']}',),centerTitle: true,),
      body: FutureBuilder(
          future: getBitacoras(arguments['aid']),
          builder: (context,snapshot){
            if(snapshot.hasData) {
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
                                    "aid":arguments['aid']
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
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.pushNamed(context, '/insertarB',arguments: {
            "aid" : arguments['aid']
          });
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
