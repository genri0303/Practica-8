import 'package:flutter/material.dart';
import '../models/incidencia.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

class ViewIncidenciaScreen extends StatelessWidget {
  final Incidencia incidencia;

  ViewIncidenciaScreen({required this.incidencia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(incidencia.titulo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              incidencia.titulo,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Fecha: ${incidencia.fecha}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              incidencia.descripcion,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            incidencia.fotoPath.isNotEmpty
                ? Image.file(File(incidencia.fotoPath))
                : Container(),
            SizedBox(height: 20),
            incidencia.audioPath.isNotEmpty
                ? ElevatedButton(
                    onPressed: () async {
                      final player = AudioPlayer();
                      await player.setSource(UrlSource(incidencia.audioPath));
                      await player.resume();
                    },
                    child: Text('Reproducir Audio'),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
