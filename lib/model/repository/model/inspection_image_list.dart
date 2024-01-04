import 'package:safecty/model/repository/model/inspection_image.dart';

class InspectionImageList {
  InspectionImageList({
    required this.listId,
    required this.images,
  });

  factory InspectionImageList.fromMap(Map<String, dynamic> map) =>
      InspectionImageList(
        listId: map[_AttributeKeys.listId].toString(),
        images: List<InspectionImage>.from(
          (map[_AttributeKeys.images] as List<dynamic>).map(
            (param) => InspectionImage.fromMap(param),
          ),
        ),
      );

  final String listId;
  final List<InspectionImage> images;

  static const storeName = 'images';

  static Map<String, dynamic> toMap(InspectionImageList inspectionList) =>
      <String, dynamic>{
        _AttributeKeys.listId: inspectionList.listId,
        _AttributeKeys.images: inspectionList.images
            .map((param) => InspectionImage.toMap(param))
            .toList(),
      };
}

abstract class _AttributeKeys {
  static const String listId = 'listId';
  static const String images = 'images';
}
