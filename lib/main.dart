import 'package:dam_u4_practica1/actualizarAuto.dart';
import 'package:dam_u4_practica1/actualizarBitacora.dart';
import 'package:dam_u4_practica1/bitacorasporfecha.dart';
import 'package:dam_u4_practica1/insertarAuto.dart';
import 'package:dam_u4_practica1/insertarBitacora.dart';
import 'package:dam_u4_practica1/principal.dart';
import 'package:dam_u4_practica1/vehiculosenuso.dart';
import 'package:dam_u4_practica1/verBitacora.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => Principal(),
        '/insertarA': (context) => InsertarAuto(),
        '/actualizarA' : (context) => ActualizarAuto(),
        '/insertarB' : (context) => InsertarBitacora(),
        '/actualizarB': (context) => ActualizarBitacora(),
        '/verB' : (context) => verBitacora(),
        '/verBfecha':(context) => VerBitacorasFecha(),
        '/vehiculoUso': (context) => VehiculoEnUso()
      },
    );
  }
}
