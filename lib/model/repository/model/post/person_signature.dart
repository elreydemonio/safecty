class PersonSignature {
  PersonSignature({
    this.base64,
    required this.fieldInspectionId,
    required this.identificationCard,
    required this.workCenterId,
  });

  final String identificationCard;
  final String? base64;
  final int fieldInspectionId;
  final int workCenterId;

  String toMap() {
    return '$fieldInspectionId|$base64|$identificationCard|$workCenterId';
  }
}
