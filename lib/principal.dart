import 'package:dam_u4_practica1/Vehiculos.dart';
import 'package:dam_u4_practica1/buscarBitacora.dart';
import 'package:dam_u4_practica1/firestoredb.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Vehiculo(),
    BuscarBitacora()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash_sharp),
            label: 'VehicuLos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
      ),
    );
  }
}
