class EvidenceInspection {
  EvidenceInspection({
    required this.base64,
    required this.inspectionId,
  });

  final String base64;
  final int inspectionId;

  String toMap() {
    return '$inspectionId|$base64';
  }
}
