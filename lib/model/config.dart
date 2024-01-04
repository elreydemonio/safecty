import 'endpoints.dart';

class Config {
  Config({
    required this.databaseFileName,
    required this.endpoints,
  });

  factory Config.fromMap(Map<String, dynamic> map) => Config(
        databaseFileName: map[_AttributesKeys.databaseFileName],
        endpoints: Endpoints.fromMap(
          map[_AttributesKeys.endpoints] as Map<String, dynamic>,
        ),
      );

  final String databaseFileName;
  final Endpoints endpoints;
}

abstract class _AttributesKeys {
  static const databaseFileName = 'databaseFileName';
  static const String endpoints = 'endpoints';
}
