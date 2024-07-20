import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/incidencia.dart';
import 'add_incidencia_screen.dart';
import 'view_incidencia_screen.dart';
import '../providers/incidencia_provider.dart';
import '../widgets/incidencia_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final incidenciaProvider = Provider.of<IncidenciaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              incidenciaProvider.clearIncidencias();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: incidenciaProvider.incidencias.length,
        itemBuilder: (context, index) {
          final incidencia = incidenciaProvider.incidencias[index];
          return IncidenciaTile(incidencia: incidencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddIncidenciaScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
