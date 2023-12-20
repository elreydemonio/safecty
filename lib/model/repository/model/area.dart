class Area {
  Area({
    required this.description,
    required this.companyId,
    required this.areaId,
  });

  factory Area.fromMap(Map<String, dynamic> map) => Area(
        description: map[_AttributeKeys.description].toString(),
        companyId: int.parse(map[_AttributeKeys.companyId].toString()),
        areaId: int.parse(map[_AttributeKeys.areaId].toString()),
      );

  final String description;
  final int companyId;
  final int areaId;
}

abstract class _AttributeKeys {
  static const String companyId = 'intIdEmpresa';
  static const String areaId = 'intIdArea';
  static const String description = 'strDescripcion';
}
