class InspectionPlanTable {
  InspectionPlanTable({
    required this.inspectorId,
    required this.documentInspector,
    required this.fullName,
    required this.month,
    required this.scheduled,
    required this.executed,
    required this.pending,
    required this.inspectionId,
    required this.inspectionName,
    required this.inspectionTypeId,
    required this.description,
    required this.riskId,
    required this.riskName,
    required this.workCenterId,
  });

  factory InspectionPlanTable.fromMap(Map<String, dynamic> map) =>
      InspectionPlanTable(
        inspectorId: map[_AttributeKeys.inspectorId].toString(),
        documentInspector: map[_AttributeKeys.documentInspector].toString(),
        fullName: map[_AttributeKeys.fullName].toString(),
        month: map[_AttributeKeys.month].toString(),
        scheduled: double.parse(map[_AttributeKeys.scheduled].toString()),
        executed: double.parse(map[_AttributeKeys.executed].toString()),
        pending: double.parse(map[_AttributeKeys.pending].toString()),
        inspectionId: int.parse(map[_AttributeKeys.inspectionId].toString()),
        inspectionName: map[_AttributeKeys.inspectionName].toString(),
        inspectionTypeId:
            int.parse(map[_AttributeKeys.inspectionTypeId].toString()),
        description: map[_AttributeKeys.description].toString(),
        riskId: int.parse(map[_AttributeKeys.riskId].toString()),
        riskName: map[_AttributeKeys.riskName].toString(),
        workCenterId: int.parse(map[_AttributeKeys.workCenterId].toString()),
      );

  final String inspectorId;
  final String documentInspector;
  final String fullName;
  final String month;
  final double scheduled;
  final double executed;
  final double pending;
  final int inspectionId;
  final String inspectionName;
  final int inspectionTypeId;
  final String description;
  final int riskId;
  final String riskName;
  final int workCenterId;
}

abstract class _AttributeKeys {
  static const String inspectorId = 'idInspector';
  static const String documentInspector = 'documentoInspector';
  static const String fullName = 'NombreProfesional';
  static const String month = 'Mes';
  static const String scheduled = 'Programadas';
  static const String executed = 'Ejecutadas';
  static const String pending = 'Pendientes';
  static const String inspectionId = 'intIdInspeccion';
  static const String inspectionName = 'strDescripcionInspeccion';
  static const String inspectionTypeId = 'intIdTipoInspeccion';
  static const String description = 'strDescripcion';
  static const String riskId = 'intIdRiesgo';
  static const String riskName = 'strDescripcionRiesgo';
  static const String workCenterId = 'idCentroTrabajo';
}
