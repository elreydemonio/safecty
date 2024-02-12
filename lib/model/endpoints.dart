class Endpoints {
  Endpoints({
    required this.baseUrlGet,
    required this.baseUrlPost,
    required this.baseUrlEmail,
    required this.getWorkCenterByPerson,
    required this.login,
    required this.workCenter,
    required this.inspectionsPlanPending,
    required this.area,
    required this.inspection,
    required this.risks,
    required this.parameter,
    required this.person,
    required this.savedInspection,
    required this.savedSignature,
    required this.savedEvidence,
    required this.validateInspection,
    required this.sendEmail,
  });

  factory Endpoints.fromMap(Map<String, dynamic> map) => Endpoints(
        baseUrlGet: map[_AttributesKeys.baseUrlGet],
        baseUrlPost: map[_AttributesKeys.baseUrlPost],
        baseUrlEmail: map[_AttributesKeys.baseUrlEmail],
        getWorkCenterByPerson: map[_AttributesKeys.getWorkCenterByPerson],
        login: map[_AttributesKeys.login],
        workCenter: map[_AttributesKeys.workCenter],
        inspectionsPlanPending: map[_AttributesKeys.inspectionsPlanPending],
        area: map[_AttributesKeys.area],
        inspection: map[_AttributesKeys.inspection],
        risks: map[_AttributesKeys.risks],
        parameter: map[_AttributesKeys.parameter],
        person: map[_AttributesKeys.person],
        savedInspection: map[_AttributesKeys.savedInspection],
        savedSignature: map[_AttributesKeys.savedSignature],
        savedEvidence: map[_AttributesKeys.savedEvidence],
        validateInspection: map[_AttributesKeys.validateInspection],
        sendEmail: map[_AttributesKeys.sendEmail],
      );

  final String baseUrlGet;
  final String baseUrlPost;
  final String baseUrlEmail;
  final String getWorkCenterByPerson;
  final String login;
  final String workCenter;
  final String inspectionsPlanPending;
  final String area;
  final String inspection;
  final String risks;
  final String parameter;
  final String savedInspection;
  final String person;
  final String savedSignature;
  final String savedEvidence;
  final String validateInspection;
  final String sendEmail;
}

abstract class _AttributesKeys {
  static const baseUrlGet = 'baseUrlGet';
  static const baseUrlPost = 'baseUrlPost';
  static const baseUrlEmail = 'baseUrlEmail';
  static const getWorkCenterByPerson = 'getWorkCenterByPerson';
  static const login = 'login';
  static const workCenter = 'workCenter';
  static const inspectionsPlanPending = 'inspectionsPlanPending';
  static const area = 'area';
  static const inspection = 'inspection';
  static const risks = 'risks';
  static const parameter = 'parameter';
  static const person = 'person';
  static const savedInspection = 'savedInspection';
  static const savedSignature = 'savedSignature';
  static const savedEvidence = 'savedEvidence';
  static const validateInspection = 'validateInspection';
  static const sendEmail = 'sendEmail';
}
