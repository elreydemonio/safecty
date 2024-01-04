import 'package:safecty/model/repository/model/inspection_person.dart';

class InspectionPersonList {
  InspectionPersonList({
    required this.listId,
    required this.persons,
  });

  factory InspectionPersonList.fromMap(Map<String, dynamic> map) =>
      InspectionPersonList(
        listId: map[_AttributeKeys.listId].toString(),
        persons: List<InspectionPerson>.from(
          (map[_AttributeKeys.persons] as List<dynamic>).map(
            (param) => InspectionPerson.fromMap(param),
          ),
        ),
      );

  final String listId;
  final List<InspectionPerson> persons;

  static const storeName = 'images';

  static Map<String, dynamic> toMap(InspectionPersonList inspectionList) =>
      <String, dynamic>{
        _AttributeKeys.listId: inspectionList.listId,
        _AttributeKeys.persons: inspectionList.persons
            .map((param) => InspectionPerson.toMap(param))
            .toList(),
      };
}

abstract class _AttributeKeys {
  static const String listId = 'listId';
  static const String persons = 'persons';
}
