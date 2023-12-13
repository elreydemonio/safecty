class User {
  User({
    required this.password,
    required this.identificationCard,
    required this.fullName,
    required this.typePersonId,
    required this.userId,
    required this.tokenGuide,
    this.profilePicture,
  });

  factory User.fromMap(Map<String, dynamic> map) => User(
        password: map[_AttributeKeys.password].toString(),
        fullName: map[_AttributeKeys.fullName].toString(),
        identificationCard: map[_AttributeKeys.identificationCard].toString(),
        typePersonId: int.parse(map[_AttributeKeys.typePersonId].toString()),
        tokenGuide: map[_AttributeKeys.tokenGuide].toString(),
        profilePicture: map[_AttributeKeys.profilePicture]?.toString(),
        userId: int.parse(map[_AttributeKeys.userId].toString()),
      );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      password: json[_AttributeKeys.password].toString(),
      fullName: json[_AttributeKeys.fullName].toString(),
      identificationCard: json[_AttributeKeys.identificationCard].toString(),
      typePersonId: int.parse(json[_AttributeKeys.typePersonId].toString()),
      tokenGuide: json[_AttributeKeys.tokenGuide].toString(),
      profilePicture: json[_AttributeKeys.profilePicture]?.toString(),
      userId: int.parse(json[_AttributeKeys.userId].toString()),
    );
  }

  final String password;
  String identificationCard;
  int typePersonId;
  final String fullName;
  final String tokenGuide;
  String? profilePicture;
  int userId;

  static Map<String, dynamic> toMap(User user) => <String, dynamic>{
        _AttributeKeys.password: user.password,
        _AttributeKeys.fullName: user.fullName,
        _AttributeKeys.userId: user.userId,
        _AttributeKeys.profilePicture: user.profilePicture,
        _AttributeKeys.tokenGuide: user.tokenGuide,
        _AttributeKeys.identificationCard: user.identificationCard,
        _AttributeKeys.typePersonId: user.typePersonId,
      };
}

abstract class _AttributeKeys {
  static const String password = 'strPassword';
  static const String identificationCard = 'strCedula';
  static const String typePersonId = 'intTipoPersona';
  static const String fullName = 'strNombreCompleto';
  static const String tokenGuide = 'TokenGuiId';
  static const String profilePicture = 'strRutaFoto';
  static const String userId = 'IdPersona';
}
