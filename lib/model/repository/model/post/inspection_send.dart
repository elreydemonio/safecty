import 'dart:convert';

class InspectionSend {
  int id;
  String inspectionName;
  int intIdArea;
  int idCentroTrabajo;
  int idInspeccion;
  int idRiesgo;
  int isPositive;
  String observacion;
  String idUsuario;

  InspectionSend({
    required this.id,
    required this.inspectionName,
    required this.intIdArea,
    required this.idCentroTrabajo,
    required this.idInspeccion,
    required this.idRiesgo,
    required this.isPositive,
    required this.observacion,
    required this.idUsuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'inspectionName': inspectionName.toString(),
      'intIdArea': intIdArea,
      'idCentroTrabajo': idCentroTrabajo,
      'idInspeccion': idInspeccion,
      'idRiesgo': idRiesgo,
      'isPositive': isPositive,
      'Observacion': observacion,
      'idUsuario': idUsuario,
    };
  }

  String toJson() => jsonEncode(toMap());
}

class Parameter {
  bool bitCumple;
  bool dtfecuser;
  int id;
  String intIdInspeccion;
  int intIdInspeccionFk;
  String idParametro;
  String intIdRiesgo;
  String strDescripcionParametro;

  Parameter({
    required this.bitCumple,
    required this.dtfecuser,
    required this.id,
    required this.intIdInspeccion,
    required this.intIdInspeccionFk,
    required this.idParametro,
    required this.intIdRiesgo,
    required this.strDescripcionParametro,
  });

  Map<String, dynamic> toMap() {
    return {
      'bitCumple': bitCumple,
      'dtfecuser': dtfecuser,
      'id': id,
      'intIdInspeccion': intIdInspeccion,
      'intIdInspeccionFk': intIdInspeccionFk,
      'idParametro': idParametro,
      'intIdRiesgo': intIdRiesgo,
      'strDescripcionParametro': strDescripcionParametro,
    };
  }

  String toJson() => jsonEncode(toMap());
}
