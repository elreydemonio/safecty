class Risk {
  Risk({
    required this.description,
    required this.riskId,
  });

  factory Risk.fromMap(Map<String, dynamic> map) => Risk(
        description: map[_AttributeKeys.description].toString(),
        riskId: int.parse(map[_AttributeKeys.riskId].toString()),
      );

  final String description;
  final int riskId;
}

abstract class _AttributeKeys {
  static const String description = 'strDescripcionRiesgo';
  static const String riskId = 'intIdRiesgo';
}
