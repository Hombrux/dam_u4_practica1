import 'package:flutter/material.dart';
import 'firestoredb.dart';

class VehiculoEnUso extends StatefulWidget {
  const VehiculoEnUso({Key? key}) : super(key: key);

  @override
  State<VehiculoEnUso> createState() => _VehiculoEnUsoState();
}

class _VehiculoEnUsoState extends State<VehiculoEnUso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Vehiculos en uso'),centerTitle: true,),
      body: FutureBuilder(
          future: buscarVehiculosUso(),
          builder: (context,snapshot){
            if(snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.car_crash_sharp),
                      title: Text(snapshot.data?[index]['tipo'] + " - " + snapshot.data?[index]['placa']),
                      subtitle: Text(snapshot.data?[index]['depto']),
                      onTap: (){
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('¿Que desea hacer con el auto ${snapshot.data?[index]['placa']}?'),
                            actions: [
                              TextButton(
                                child: const Text('Eliminar'),
                                onPressed: () {
                                  showDialog(context: context, builder: (BuildContext context){
                                    return AlertDialog(title: Text('¿Esta seguro?'),
                                      actions: [
                                        TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('Cancelar')),
                                        TextButton(onPressed: (){
                                          eliminarVehiculo(snapshot.data?[index]['aid']);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          setState(() {});
                                        }, child: const Text('Eliminar'))
                                      ],);
                                  });
                                },
                              ),
                              TextButton(
                                child: const Text('Actualizar'),
                                onPressed: () async{
                                  await Navigator.pushNamed(context,'/actualizarA',arguments:{
                                    "placa": snapshot.data?[index]['placa'],
                                    "tipo" : snapshot.data?[index]['tipo'],
                                    "numeroserie": snapshot.data?[index]['numeroserie'],
                                    "combustible": snapshot.data?[index]['combustible'],
                                    "tanque" : snapshot.data?[index]['tanque'],
                                    "trabajador" : snapshot.data?[index]['trabajador'],
                                    "depto": snapshot.data?[index]['depto'],
                                    "resguardadopor": snapshot.data?[index]['resguardadopor'],
                                    "aid":snapshot.data?[index]['aid']
                                  });
                                  setState(() {});
                                },
                              ),
                              TextButton(
                                child: const Text('Ver bitacora'),
                                onPressed: () async{
                                  await Navigator.pushNamed(context, '/verB',arguments: {
                                    "aid":snapshot.data?[index]['aid'],
                                    "placa":snapshot.data?[index]['placa']
                                  });
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
