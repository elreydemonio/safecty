class Inspection {
  Inspection({
    required this.inspectionId,
    required this.companyId,
    required this.areaId,
    required this.descriptionInspection,
    this.area,
    required this.riskId,
    required this.parameters,
    required this.imagePath,
  });

  factory Inspection.fromMap(Map<String, dynamic> map) => Inspection(
        descriptionInspection:
            map[_AttributeKeys.descriptionInspection].toString(),
        companyId: int.parse(map[_AttributeKeys.companyId].toString()),
        areaId: map[_AttributeKeys.areaId] == null
            ? null
            : int.parse(map[_AttributeKeys.areaId].toString()),
        riskId: int.parse(map[_AttributeKeys.riskId].toString()),
        inspectionId: int.parse(map[_AttributeKeys.inspectionId].toString()),
        area: map[_AttributeKeys.area].toString(),
        imagePath: map[_AttributeKeys.imagePath].toString(),
        parameters: map[_AttributeKeys.parameters] as bool? ?? false,
      );

  final int inspectionId;
  final int? areaId;
  final int riskId;
  final int companyId;
  final String descriptionInspection;
  final String imagePath;
  final bool parameters;
  final String? area;

  static Map<String, dynamic> toMap(Inspection inspection) => <String, dynamic>{
        _AttributeKeys.companyId: inspection.companyId,
        _AttributeKeys.inspectionId: inspection.inspectionId,
        _AttributeKeys.descriptionInspection: inspection.descriptionInspection,
        _AttributeKeys.riskId: inspection.riskId,
        _AttributeKeys.parameters: inspection.parameters,
        _AttributeKeys.areaId: inspection.areaId,
        _AttributeKeys.area: inspection.area,
        _AttributeKeys.imagePath: inspection.imagePath
      };
}

abstract class _AttributeKeys {
  static const String companyId = 'intIdEmpresa';
  static const String inspectionId = 'intIdInspeccion';
  static const String descriptionInspection = 'strDescripcionInspeccion';
  static const String riskId = 'intIdRiesgo';
  static const String parameters = 'parametros_precumplidos';
  static const String areaId = 'intIdArea';
  static const String area = 'Area';
  static const String imagePath = 'strRutaImagen';
}
