import 'package:safecty/model/repository/model/parameter_inspecton.dart';

class ParametersInspectionList {
  ParametersInspectionList({
    required this.listId,
    required this.parameters,
  });

  factory ParametersInspectionList.fromMap(Map<String, dynamic> map) =>
      ParametersInspectionList(
        listId: map[_AttributeKeys.listId].toString(),
        parameters: List<ParameterInspection>.from(
          (map[_AttributeKeys.parameters] as List<dynamic>).map(
            (param) => ParameterInspection.fromMap(param),
          ),
        ),
      );

  final String listId;
  final List<ParameterInspection> parameters;

  static const storeName = 'inspectionList';

  static Map<String, dynamic> toMap(ParametersInspectionList inspectionList) =>
      <String, dynamic>{
        _AttributeKeys.listId: inspectionList.listId,
        _AttributeKeys.parameters: inspectionList.parameters
            .map((param) => ParameterInspection.toMap(param))
            .toList(),
      };
}

abstract class _AttributeKeys {
  static const String listId = 'listId';
  static const String parameters = 'parameters';
}
