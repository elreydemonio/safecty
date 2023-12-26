class ParameterInspection {
  ParameterInspection({
    required this.inspectionId,
    required this.descriptionInspection,
    required this.riskId,
    required this.parameters,
    this.imagePath,
    required this.isCheckNo,
    required this.isCheckYes,
    required this.parameterId,
    required this.descriptionParameter,
  });

  factory ParameterInspection.fromMap(Map<String, dynamic> map) =>
      ParameterInspection(
        descriptionInspection:
            map[_AttributeKeys.descriptionInspection].toString(),
        riskId: int.parse(map[_AttributeKeys.riskId].toString()),
        inspectionId: int.parse(map[_AttributeKeys.inspectionId].toString()),
        parameterId: int.parse(map[_AttributeKeys.parameterId].toString()),
        descriptionParameter:
            map[_AttributeKeys.descriptionParameter].toString(),
        imagePath: map[_AttributeKeys.imagePath].toString(),
        parameters: map[_AttributeKeys.parameters] as bool? ?? false,
        isCheckNo: int.parse(map[_AttributeKeys.isCheckNo].toString()),
        isCheckYes: int.parse(map[_AttributeKeys.isCheckYes].toString()),
      );

  final int inspectionId;
  final int riskId;
  final int parameterId;
  final String descriptionInspection;
  final String descriptionParameter;
  final String? imagePath;
  final bool parameters;
  final int isCheckYes;
  final int isCheckNo;
}

abstract class _AttributeKeys {
  static const String inspectionId = 'intIdInspeccion';
  static const String descriptionInspection = 'strDescripcionInspeccion';
  static const String riskId = 'intIdRiesgo';
  static const String parameters = 'parametros_precumplidos';
  static const String parameterId = 'intIdParametro';
  static const String descriptionParameter = 'strDescripcionParametro';
  static const String isCheckYes = 'Si';
  static const String isCheckNo = 'No';
  static const String imagePath = 'rutaImagenParametro';
}
