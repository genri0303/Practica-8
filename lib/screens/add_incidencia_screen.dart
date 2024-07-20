import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'dart:io';
import '../models/incidencia.dart';
import '../providers/incidencia_provider.dart';

class AddIncidenciaScreen extends StatefulWidget {
  @override
  _AddIncidenciaScreenState createState() => _AddIncidenciaScreenState();
}

class _AddIncidenciaScreenState extends State<AddIncidenciaScreen> {
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  File? _image;
  String? _audioPath;
  bool _isRecording = false;
  final _audioRecorder = Record();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Incidencia'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No se ha seleccionado una imagen.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Seleccionar Imagen'),
            ),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _recordAudio,
              child: Text(_isRecording ? 'Detener Grabación' : 'Grabar Audio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addIncidencia,
              child: Text('Guardar Incidencia'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _recordAudio() async {
    if (await _audioRecorder.hasPermission()) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        path: filePath,
        encoder: AudioEncoder.AAC,
        bitRate: 128000,
        samplingRate: 44100,
      );

      setState(() {
        _isRecording = true;
        _audioPath = filePath;
      });
    }
  }

  Future<void> _stopRecording() async {
    await _audioRecorder.stop();

    setState(() {
      _isRecording = false;
    });
  }

  void _addIncidencia() {
    final titulo = _tituloController.text;
    final descripcion = _descripcionController.text;
    final fecha = DateTime.now();
    final fotoPath = _image?.path ?? '';
    final audioPath = _audioPath ?? '';

    if (titulo.isNotEmpty && descripcion.isNotEmpty) {
      final incidencia = Incidencia(
        titulo: titulo,
        fecha: fecha,
        descripcion: descripcion,
        fotoPath: fotoPath,
        audioPath: audioPath,
      );

      Provider.of<IncidenciaProvider>(context, listen: false).addIncidencia(incidencia);
      Navigator.pop(context);
    }
  }
}
