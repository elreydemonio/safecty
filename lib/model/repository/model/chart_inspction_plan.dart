class CharInspectionPlan {
  CharInspectionPlan({
    required this.inspectorId,
    required this.documentInspector,
    required this.fullName,
    required this.month,
    required this.scheduled,
    required this.executed,
    required this.pending,
    required this.fulfill,
  });

  factory CharInspectionPlan.fromMap(Map<String, dynamic> map) =>
      CharInspectionPlan(
        inspectorId: map[_AttributeKeys.inspectorId].toString(),
        documentInspector: map[_AttributeKeys.documentInspector].toString(),
        fullName: map[_AttributeKeys.fullName].toString(),
        month: map[_AttributeKeys.month].toString(),
        scheduled: double.parse(map[_AttributeKeys.scheduled].toString()),
        executed: double.parse(map[_AttributeKeys.executed].toString()),
        pending: double.parse(map[_AttributeKeys.pending].toString()),
        fulfill: double.parse(map[_AttributeKeys.fulfill].toString()),
      );

  final String inspectorId;
  final String documentInspector;
  final String fullName;
  final String month;
  final double scheduled;
  final double executed;
  final double pending;
  final double fulfill;
}

abstract class _AttributeKeys {
  static const String inspectorId = 'idInspector';
  static const String documentInspector = 'documentoInspector';
  static const String fullName = 'NombreProfesional';
  static const String month = 'Mes';
  static const String scheduled = 'Programadas';
  static const String executed = 'Ejecutadas';
  static const String pending = 'Pendientes';
  static const String fulfill = 'PorcCumplimiento';
}
