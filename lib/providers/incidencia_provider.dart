import 'package:flutter/material.dart';
import '../models/incidencia.dart';

class IncidenciaProvider with ChangeNotifier {
  List<Incidencia> _incidencias = [];

  List<Incidencia> get incidencias => _incidencias;

  void addIncidencia(Incidencia incidencia) {
    _incidencias.add(incidencia);
    notifyListeners();
  }

  void clearIncidencias() {
    _incidencias.clear();
    notifyListeners();
  }
}
