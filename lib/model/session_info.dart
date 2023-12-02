import 'package:json_class/json_class.dart';

class SessionInfo extends JsonClass {
  SessionInfo({
    required this.accessToken,
    required this.expiresIn,
    this.generatedAt,
    required this.tokenType,
  });

  factory SessionInfo.fromMap(Map<String, dynamic> map) => SessionInfo(
        accessToken: map[_AttributeKeys.accessToken],
        expiresIn: map[_AttributeKeys.expiresIn],
        generatedAt: map[_AttributeKeys.generatedAt],
        tokenType: map[_AttributeKeys.tokenType],
      );

  final String accessToken;
  final int expiresIn;
  String? generatedAt;
  final String tokenType;

  @override
  Map<String, dynamic> toJson() => {
        _AttributeKeys.accessToken: accessToken,
        _AttributeKeys.expiresIn: expiresIn,
        _AttributeKeys.generatedAt: generatedAt,
        _AttributeKeys.tokenType: tokenType
      };
}

abstract class _AttributeKeys {
  static const String accessToken = 'access_token';
  static const String expiresIn = 'expires_in';
  static const String generatedAt = 'generated_at';
  static const String tokenType = 'token_type';
}
