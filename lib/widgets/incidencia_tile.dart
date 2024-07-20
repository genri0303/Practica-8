import 'package:flutter/material.dart';
import '../models/incidencia.dart';
import '../screens/view_incidencia_screen.dart';

class IncidenciaTile extends StatelessWidget {
  final Incidencia incidencia;

  IncidenciaTile({required this.incidencia});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(incidencia.titulo),
      subtitle: Text('Fecha: ${incidencia.fecha}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewIncidenciaScreen(incidencia: incidencia),
          ),
        );
      },
    );
  }
}
