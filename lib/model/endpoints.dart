class Endpoints {
  Endpoints({
    required this.baseUrlGet,
    required this.getWorkCenterByPerson,
    required this.login,
    required this.workCenter,
  });

  factory Endpoints.fromMap(Map<String, dynamic> map) => Endpoints(
        baseUrlGet: map[_AttributesKeys.baseUrlGet],
        getWorkCenterByPerson: map[_AttributesKeys.getWorkCenterByPerson],
        login: map[_AttributesKeys.login],
        workCenter: map[_AttributesKeys.workCenter],
      );

  final String baseUrlGet;
  final String getWorkCenterByPerson;
  final String login;
  final String workCenter;
}

abstract class _AttributesKeys {
  static const baseUrlGet = 'baseUrlGet';
  static const getWorkCenterByPerson = 'getWorkCenterByPerson';
  static const login = 'login';
  static const workCenter = 'workCenter';
}
