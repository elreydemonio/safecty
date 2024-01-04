import 'dart:io';

class InspectionPerson {
  InspectionPerson({
    required this.typePersonId,
    required this.businessId,
    required this.personId,
    required this.workPlaceId,
    this.positionId,
    this.file,
    required this.businessName,
    required this.professionalName,
    required this.professionalSurname,
    required this.identificationCard,
    required this.workPlace,
  });

  factory InspectionPerson.fromMap(Map<String, dynamic> map) =>
      InspectionPerson(
        businessId: int.parse(map[_AttributeKeys.businessId].toString()),
        personId: int.parse(map[_AttributeKeys.personId].toString()),
        workPlaceId: int.parse(map[_AttributeKeys.workPlaceId].toString()),
        positionId: map[_AttributeKeys.positionId] != null
            ? int.parse(map[_AttributeKeys.positionId].toString())
            : null,
        typePersonId: int.parse(map[_AttributeKeys.typePersonId].toString()),
        businessName: map[_AttributeKeys.businessName].toString(),
        professionalName: map[_AttributeKeys.professionalName].toString(),
        professionalSurname: map[_AttributeKeys.professionalSurname],
        identificationCard: map[_AttributeKeys.identificationCard].toString(),
        workPlace: map[_AttributeKeys.workPlace].toString(),
      );

  final int businessId;
  final int personId;
  final int typePersonId;
  final int workPlaceId;
  final int? positionId;
  final String businessName;
  final String professionalName;
  final String professionalSurname;
  final String identificationCard;
  final String workPlace;
  File? file;

  static const storeName = 'persons';

  static const id = 'InspectionPerson';

  static Map<String, dynamic> toMap(InspectionPerson inspectionPerson) =>
      <String, dynamic>{
        _AttributeKeys.businessId: inspectionPerson.businessId,
        _AttributeKeys.personId: inspectionPerson.personId,
        _AttributeKeys.typePersonId: inspectionPerson.typePersonId,
        _AttributeKeys.workPlaceId: inspectionPerson.workPlaceId,
        _AttributeKeys.positionId: inspectionPerson.positionId,
        _AttributeKeys.businessName: inspectionPerson.businessName,
        _AttributeKeys.professionalName: inspectionPerson.professionalName,
        _AttributeKeys.professionalSurname:
            inspectionPerson.professionalSurname,
        _AttributeKeys.workPlace: inspectionPerson.workPlace,
        _AttributeKeys.identificationCard: inspectionPerson.identificationCard
      };
}

abstract class _AttributeKeys {
  static const String businessId = 'intIdEmpresa';
  static const String businessName = 'strRazonSocial';
  static const String personId = 'intIdPersona';
  static const String professionalName = 'strNombreProfesional';
  static const String professionalSurname = 'strApellidoProfesional';
  static const String identificationCard = 'strCedula';
  static const String typePersonId = 'intTipoPersona';
  static const String workPlaceId = 'idCentroTrabajo';
  static const String workPlace = 'strCentroTrabajo';
  static const String positionId = 'intIdCargos';
}
