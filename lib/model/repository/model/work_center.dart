class WorkCenter {
  WorkCenter({
    required this.companyId,
    required this.businessName,
    required this.informativeMessage,
    required this.typePersonId,
    required this.userId,
    required this.companyLogo,
  });

  factory WorkCenter.fromMap(Map<String, dynamic> map) => WorkCenter(
        companyId: int.parse(map[_AttributeKeys.companyId].toString()),
        businessName: map[_AttributeKeys.businessName].toString(),
        informativeMessage: map[_AttributeKeys.informativeMessage].toString(),
        typePersonId: int.parse(map[_AttributeKeys.typePersonId].toString()),
        userId: int.parse(map[_AttributeKeys.userId].toString()),
        companyLogo: map[_AttributeKeys.companyLogo].toString(),
      );

  final int companyId;
  int userId;
  String businessName;
  final String informativeMessage;
  int typePersonId;
  String companyLogo;

  static Map<String, dynamic> toMap(WorkCenter workCenter) => <String, dynamic>{
        _AttributeKeys.companyLogo: workCenter.companyLogo,
        _AttributeKeys.businessName: workCenter.businessName,
        _AttributeKeys.companyId: workCenter.companyId,
        _AttributeKeys.userId: workCenter.userId,
        _AttributeKeys.informativeMessage: workCenter.informativeMessage,
        _AttributeKeys.typePersonId: workCenter.typePersonId,
      };
}

abstract class _AttributeKeys {
  static const String companyId = 'intIdEmpresa';
  static const String userId = 'intIdPersona';
  static const String typePersonId = 'intTipoPersona';
  static const String businessName = 'strRazonSocial';
  static const String informativeMessage = 'mensajeInformativo';
  static const String companyLogo = 'strRutaLogoCt';
}
