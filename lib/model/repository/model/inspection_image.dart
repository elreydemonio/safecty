import 'dart:io';

class InspectionImage {
  InspectionImage(this.description, this.file);
  final File file;
  final String? description;

  static Map<String, dynamic> toMap(InspectionImage image) {
    return {
      'description': image.description,
      'filePath': image.file.path,
    };
  }

  static const storeName = 'images';

  static const String _id = 'InspectionImages';

  String get id => _id;

  static InspectionImage fromMap(Map<String, dynamic> map) {
    return InspectionImage(
      map[_AttributeKeys.description] as String?,
      File(map[_AttributeKeys.filePath] as String),
    );
  }
}

abstract class _AttributeKeys {
  static const String filePath = 'filePath';
  static const String description = 'description';
}
