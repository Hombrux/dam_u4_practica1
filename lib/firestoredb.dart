import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getVehiculo() async{
  List autos = [];
  CollectionReference coleccionAutos = db.collection('vehiculo');
  QuerySnapshot queryAutos = await coleccionAutos.get();
  queryAutos.docs.forEach((documento){
    final Map<String,dynamic> data = documento.data() as Map<String,dynamic>;
    final auto = {
      "placa": data['placa'],
      "tipo" : data['tipo'],
      "numeroserie": data['numeroserie'],
      "combustible": data['combustible'],
      "tanque" : data['tanque'],
      "trabajador" : data['trabajador'],
      "depto": data['depto'],
      "resguardadopor":data['resguardadopor'],
      "aid" : documento.id
    };
    autos.add(auto);
  });
  await Future.delayed(const Duration(seconds:1));
  return autos;
}
Future<void> agregarVehiculo(Map<String, dynamic> datosVehiculo) async {
  CollectionReference coleccionAutos = db.collection('vehiculo');
  await coleccionAutos.add(datosVehiculo);
}
Future<void> actualizarVehiculo(String id, Map<String, dynamic> datosVehiculo) async {
  CollectionReference coleccionAutos = db.collection('vehiculo');
  await coleccionAutos.doc(id).update(datosVehiculo);
}
Future<void> eliminarVehiculo(String id) async{
  await db.collection('vehiculo').doc(id).delete();
}

Future<List> getBitacoras(String ida) async{
  List bitacoras = [];
  CollectionReference vehiculosRef = db.collection('vehiculo');
  DocumentReference vehiculoRef = vehiculosRef.doc(ida);
  CollectionReference bitacoraRef = vehiculoRef.collection('BITACORA');
  QuerySnapshot querySnapshot = await bitacoraRef.get();
  querySnapshot.docs.forEach((documento){
    final Map<String,dynamic> bitacoraData = documento.data() as Map<String,dynamic>;
    final bitacora = {
      "fecha": bitacoraData['fecha'],
      "evento": bitacoraData['evento'],
      "recursos": bitacoraData['recursos'],
      "verifico": bitacoraData['verifico'],
      "fechaverificacion": bitacoraData['fechaverificacion'],
      "bid":documento.id
    };
    bitacoras.add(bitacora);
  });
  return bitacoras;
}

Future<void> agregarBitacora(String id, Map<String, dynamic> bitacora) async {
  CollectionReference coleccionAutos = db.collection('vehiculo');
  DocumentReference docAuto = coleccionAutos.doc(id);
  CollectionReference bitacorasCollection = docAuto.collection('BITACORA');
  await bitacorasCollection.add(bitacora);
}
Future<void> actualizarBitacora(String aid,String bid, Map<String,dynamic> bitacora) async {
  CollectionReference coleccionAutos = db.collection('vehiculo');
  DocumentReference docAuto = coleccionAutos.doc(aid);
  CollectionReference bitacorasCollection = docAuto.collection('BITACORA');
  await bitacorasCollection.doc(bid).update(bitacora);
}
Future<void> actualizarBitacoraF(String bid, Map<String,dynamic> bitacora) async {
  QuerySnapshot querySnapshot = await db.collectionGroup('BITACORA').where(FieldPath.documentId,isEqualTo: bid).get();
  querySnapshot.docs.forEach((documento) async{
    await documento.reference.update(bitacora);
  });
}

Future<List> buscarBitacora(String fecha) async{
  List bitacoras = [];
  QuerySnapshot querySnapshot = await db.collectionGroup('BITACORA').where('fecha',isEqualTo: fecha).get();
  querySnapshot.docs.forEach((documento){
    final Map<String,dynamic> bitacoraData = documento.data() as Map<String,dynamic>;
    final bitacora = {
      "fecha": bitacoraData['fecha'],
      "evento": bitacoraData['evento'],
      "recursos": bitacoraData['recursos'],
      "verifico": bitacoraData['verifico'],
      "fechaverificacion": bitacoraData['fechaverificacion'],
      "bid":documento.id
    };
    bitacoras.add(bitacora);
  });
  await Future.delayed(const Duration(seconds:1));
  return bitacoras;
}

Future<List> buscarVehiculosUso() async{
  List vehiculos = [];
  //QuerySnapshot querySnapshot = await db.collection('vehiculo').where('/BITACORA.fechaverificacion',isEqualTo:"12/12/2020").get();
  QuerySnapshot querySnapshot = await db.collectionGroup('BITACORA').where('fechaverificacion',isEqualTo: "").get();
  querySnapshot.docs.forEach((documento){
    DocumentReference autoPadre = documento.reference.parent.parent as DocumentReference<Object?>;
    autoPadre.get().then((autodoc) {
      final Map<String,dynamic> data = autodoc.data() as Map<String,dynamic>;
      final auto = {
        "placa": data['placa'],
        "tipo" : data['tipo'],
        "numeroserie": data['numeroserie'],
        "combustible": data['combustible'],
        "tanque" : data['tanque'],
        "trabajador" : data['trabajador'],
        "depto": data['depto'],
        "resguardadopor":data['resguardadopor'],
        "aid" : autodoc.id
      };
      vehiculos.add(auto);
    });
  });
  await Future.delayed(const Duration(seconds:1));
  return vehiculos;
}
