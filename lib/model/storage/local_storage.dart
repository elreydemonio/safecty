import 'package:safecty/model/repository/model/inspection_image.dart';
import 'package:safecty/model/repository/model/inspection_person.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';

abstract class LocalStorage {
  Future<bool> storeListParameters(List<ParameterInspection> listParameters);
  Future<bool> storeListImages(List<InspectionImage> listImage);
  Future<bool> storeListPerson(List<InspectionPerson> listPerson);
  Future<List<ParameterInspection>> getListParameters(String listId);
  Future<List<InspectionImage>> getListImage(String imageId);
  Future<List<InspectionPerson>> getPersons(String personasId);
}
