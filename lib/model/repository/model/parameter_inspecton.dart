class ParameterInspection {
  ParameterInspection({
    required this.inspectionId,
    required this.descriptionInspection,
    required this.riskId,
    required this.parameters,
    this.imagePath,
    this.isCheck,
    required this.parameterId,
    required this.descriptionParameter,
  });

  factory ParameterInspection.fromMap(Map<String, dynamic> map) {
    return ParameterInspection(
      descriptionInspection:
          map[_AttributeKeys.descriptionInspection].toString(),
      riskId: int.parse(map[_AttributeKeys.riskId].toString()),
      inspectionId: int.parse(map[_AttributeKeys.inspectionId].toString()),
      parameterId: int.parse(map[_AttributeKeys.parameterId].toString()),
      descriptionParameter: map[_AttributeKeys.descriptionParameter].toString(),
      imagePath: map[_AttributeKeys.imagePath].toString(),
      parameters: map[_AttributeKeys.parameters] as bool? ?? false,
      isCheck: map[_AttributeKeys.isCheck] != null
          ? map[_AttributeKeys.isCheck] as bool? ?? false
          : null,
    );
  }

  final int inspectionId;
  final int riskId;
  final int parameterId;
  final String descriptionInspection;
  final String descriptionParameter;
  final String? imagePath;
  final bool parameters;
  bool? isCheck;

  static const storeName = 'parameters';

  static const String id = 'parametersInspection';

  static Map<String, dynamic> toMap(ParameterInspection inspection) =>
      <String, dynamic>{
        _AttributeKeys.inspectionId: inspection.inspectionId,
        _AttributeKeys.descriptionInspection: inspection.descriptionInspection,
        _AttributeKeys.riskId: inspection.riskId,
        _AttributeKeys.parameters: inspection.parameters,
        _AttributeKeys.parameterId: inspection.parameterId,
        _AttributeKeys.descriptionParameter: inspection.descriptionParameter,
        _AttributeKeys.imagePath: inspection.imagePath,
        _AttributeKeys.isCheck: inspection.isCheck,
      };
}

abstract class _AttributeKeys {
  static const String inspectionId = 'intIdInspeccion';
  static const String descriptionInspection = 'strDescripcionInspeccion';
  static const String riskId = 'intIdRiesgo';
  static const String parameters = 'parametros_precumplidos';
  static const String parameterId = 'intIdParametro';
  static const String descriptionParameter = 'strDescripcionParametro';
  static const String imagePath = 'rutaImagenParametro';
  static const String isCheck = 'isCheck';
}
