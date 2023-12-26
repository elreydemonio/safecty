class Endpoints {
  Endpoints({
    required this.baseUrlGet,
    required this.getWorkCenterByPerson,
    required this.login,
    required this.workCenter,
    required this.inspectionsPlanPending,
    required this.area,
    required this.inspection,
    required this.risks,
    required this.parameter,
  });

  factory Endpoints.fromMap(Map<String, dynamic> map) => Endpoints(
        baseUrlGet: map[_AttributesKeys.baseUrlGet],
        getWorkCenterByPerson: map[_AttributesKeys.getWorkCenterByPerson],
        login: map[_AttributesKeys.login],
        workCenter: map[_AttributesKeys.workCenter],
        inspectionsPlanPending: map[_AttributesKeys.inspectionsPlanPending],
        area: map[_AttributesKeys.area],
        inspection: map[_AttributesKeys.inspection],
        risks: map[_AttributesKeys.risks],
        parameter: map[_AttributesKeys.parameter],
      );

  final String baseUrlGet;
  final String getWorkCenterByPerson;
  final String login;
  final String workCenter;
  final String inspectionsPlanPending;
  final String area;
  final String inspection;
  final String risks;
  final String parameter;
}

abstract class _AttributesKeys {
  static const baseUrlGet = 'baseUrlGet';
  static const getWorkCenterByPerson = 'getWorkCenterByPerson';
  static const login = 'login';
  static const workCenter = 'workCenter';
  static const inspectionsPlanPending = 'inspectionsPlanPending';
  static const area = 'area';
  static const inspection = 'inspection';
  static const risks = 'risks';
  static const parameter = 'parameter';
}
