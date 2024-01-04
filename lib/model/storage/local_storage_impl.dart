import 'package:safecty/model/repository/model/inspection_image.dart';
import 'package:safecty/model/repository/model/inspection_image_list.dart';
import 'package:safecty/model/repository/model/inspection_person.dart';
import 'package:safecty/model/repository/model/inspection_person_list.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';
import 'package:safecty/model/repository/model/parameters_inspection_list.dart';
import 'package:safecty/model/storage/local_storage.dart';
import 'package:safecty/model/storage/local_storage_logger.dart';
import 'package:sembast/sembast.dart';

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl({
    required Database database,
    required LocalStorageLogger localStorageLogger,
  })  : _database = database,
        _localStorageLogger = localStorageLogger;

  final Database _database;
  final LocalStorageLogger _localStorageLogger;

  final _storeParameters = stringMapStoreFactory.store(
    ParameterInspection.storeName,
  );

  final _storeImages = stringMapStoreFactory.store(
    InspectionImage.storeName,
  );

  final _storePerson = stringMapStoreFactory.store(
    InspectionPerson.storeName,
  );

  @override
  Future<bool> storeListParameters(
    List<ParameterInspection> listParameters,
  ) async {
    try {
      final ParametersInspectionList inspectionList = ParametersInspectionList(
        listId: ParameterInspection.id,
        parameters: listParameters,
      );

      _localStorageLogger.logStore(
        description: 'Store Inspection List',
        id: inspectionList.listId,
        path: 'details',
      );

      await _storeParameters.record(inspectionList.listId).put(
            _database,
            ParametersInspectionList.toMap(inspectionList),
          );

      return true;
    } catch (e) {
      print('Error al almacenar la lista: $e');
      return false;
    }
  }

  @override
  Future<List<ParameterInspection>> getListParameters(String listId) async {
    final Finder finder = Finder(filter: Filter.byKey(listId));
    final RecordSnapshot<String, dynamic>? recordSnapshot =
        await _storeParameters.findFirst(
      _database,
      finder: finder,
    );

    if (recordSnapshot != null && recordSnapshot.value != null) {
      final ParametersInspectionList inspectionList =
          ParametersInspectionList.fromMap(recordSnapshot.value!);
      return inspectionList.parameters;
    }

    return <ParameterInspection>[];
  }

  @override
  Future<bool> storeListImages(List<InspectionImage> listImage) async {
    try {
      final InspectionImageList imageList = InspectionImageList(
        listId: listImage[0].id,
        images: listImage,
      );

      _localStorageLogger.logStore(
        description: 'Store Inspection List',
        id: imageList.listId,
        path: 'details',
      );

      await _storeImages.record(imageList.listId).put(
            _database,
            InspectionImageList.toMap(imageList),
          );

      return true;
    } catch (e) {
      print('Error al almacenar la lista: $e');
      return false;
    }
  }

  @override
  Future<bool> storeListPerson(List<InspectionPerson> listPerson) async {
    try {
      final InspectionPersonList personList = InspectionPersonList(
        listId: InspectionPerson.id,
        persons: listPerson,
      );

      _localStorageLogger.logStore(
        description: 'Store Inspection List',
        id: personList.listId,
        path: 'details',
      );

      await _storePerson.record(personList.listId).put(
            _database,
            InspectionPersonList.toMap(personList),
          );

      return true;
    } catch (e) {
      print('Error al almacenar la lista: $e');
      return false;
    }
  }

  @override
  Future<List<InspectionImage>> getListImage(String imageId) async {
    final Finder finder = Finder(filter: Filter.byKey(imageId));
    final RecordSnapshot<String, dynamic>? recordSnapshot =
        await _storeImages.findFirst(
      _database,
      finder: finder,
    );

    if (recordSnapshot != null && recordSnapshot.value != null) {
      final InspectionImageList inspectionList =
          InspectionImageList.fromMap(recordSnapshot.value!);
      return inspectionList.images;
    }

    return <InspectionImage>[];
  }

  @override
  Future<List<InspectionPerson>> getPersons(String personasId) async {
    final Finder finder = Finder(filter: Filter.byKey(personasId));
    final RecordSnapshot<String, dynamic>? recordSnapshot =
        await _storePerson.findFirst(
      _database,
      finder: finder,
    );

    if (recordSnapshot != null && recordSnapshot.value != null) {
      final InspectionPersonList inspectionList =
          InspectionPersonList.fromMap(recordSnapshot.value!);
      return inspectionList.persons;
    }

    return <InspectionPerson>[];
  }
}
