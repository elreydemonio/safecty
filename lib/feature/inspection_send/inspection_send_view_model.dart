import 'package:safecty/core/mvvm/base_view_model.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/inspection_check/inspection_check.dart';
import 'package:safecty/model/repository/inspection_image/inspection_image.dart';
import 'package:safecty/model/repository/inspection_person/inspection_person.dart';
import 'package:safecty/model/repository/inspection_send/inspection_send.dart';
import 'package:safecty/model/repository/model/area.dart';
import 'package:safecty/model/repository/model/inspection.dart';
import 'package:safecty/model/repository/model/inspection_image.dart';
import 'package:safecty/model/repository/model/inspection_person.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';
import 'package:safecty/model/repository/model/user.dart';
import 'package:safecty/model/repository/model/work_center.dart';
import 'package:safecty/model/storage/secure_storage.dart';

enum InspectionSendViewState {
  completed,
  error,
  initial,
  loading,
  incomplete,
  incompletePerson,
  incompleteImage,
  incompleteCheck,
}

class InspectionSendViewModel extends BaseViewModel<InspectionSendViewState> {
  InspectionSendViewModel({
    required InspectionSendRepository inspectionSendRepository,
    required InspectionImageRepository inspectionImageRepository,
    required InspectionCheckRepository inspectionCheckRepository,
    required InspectionPersonRepository inspectionPersonRepository,
    required SecureStorage secureStorage,
  })  : _inspectionCheckRepository = inspectionCheckRepository,
        _inspectionPersonRepository = inspectionPersonRepository,
        _inspectionImageRepository = inspectionImageRepository,
        _inspectionSendRepository = inspectionSendRepository,
        _secureStorage = secureStorage;

  final InspectionSendRepository _inspectionSendRepository;
  final InspectionCheckRepository _inspectionCheckRepository;
  final InspectionPersonRepository _inspectionPersonRepository;
  final InspectionImageRepository _inspectionImageRepository;
  final SecureStorage _secureStorage;

  Future<void> sendInspection() async {
    setState(InspectionSendViewState.loading);
    final Inspection? inspection = await _secureStorage.getInspection();
    final WorkCenter? workCenter = await _secureStorage.getWorkCenter();
    final List<ParameterInspection>? listParameters = await _getParameters();
    final List<InspectionPerson>? listPerson = await _getPersons();
    final List<InspectionImage>? listImage = await _getImages();
    final Area? area = await _secureStorage.getArea();
    final User? user = await _secureStorage.getUser();

    if (inspection == null ||
        listParameters == null ||
        listImage == null ||
        area == null ||
        user == null ||
        listPerson == null ||
        workCenter == null) {
      setState(InspectionSendViewState.incomplete);
      return;
    }

    if (listImage.isEmpty) {
      setState(InspectionSendViewState.incompleteImage);
      return;
    }

    if (listPerson.isEmpty) {
      setState(InspectionSendViewState.incompletePerson);
      return;
    }

    if (listParameters.isEmpty) {
      setState(InspectionSendViewState.incompleteCheck);
      return;
    }

    final response = await _inspectionSendRepository.savedInspection(
      inspection: inspection,
      listParameters: listParameters,
      area: area,
      user: user,
      listEvidence: listImage,
    );

    response.fold(
      (Failure failure) => setState(InspectionSendViewState.error),
      (String? inspectionId) async {
        if (inspectionId == null || inspectionId.isEmpty) {
          setState(InspectionSendViewState.error);
        }
        _sendSignatures(
          listPerson: listPerson,
          listImage: listImage,
          inspectionIdField: int.parse(inspectionId!.replaceAll('"', '')),
          workCenterId: workCenter.companyId,
        );
      },
    );
  }

  Future<void> _sendSignatures({
    required List<InspectionPerson> listPerson,
    required List<InspectionImage> listImage,
    required int inspectionIdField,
    required int workCenterId,
  }) async {
    final sendSignature = await _inspectionSendRepository.savedSignature(
      personSignature: listPerson,
      fieldInspectionId: inspectionIdField,
      workCenterId: workCenterId,
    );
    sendSignature.fold(
      (Failure failure) => setState(InspectionSendViewState.error),
      (bool saveSignature) {
        saveSignature
            ? _finishInspection(
                listImage: listImage, inspectionIdField: inspectionIdField)
            : setState(InspectionSendViewState.error);
      },
    );
  }

  Future<void> _finishInspection({
    required List<InspectionImage> listImage,
    required int inspectionIdField,
  }) async {
    final response = await _inspectionSendRepository.savedEvidence(
      listImage,
      inspectionIdField,
    );
    response.fold(
      (Failure failure) => setState(InspectionSendViewState.error),
      (bool isSend) async {
        if (isSend) {
          final validateInspection = await _inspectionSendRepository
              .validateInspection(inspectionIdField);
          validateInspection.fold(
            (Failure failure) => setState(InspectionSendViewState.error),
            (bool validate) async {
              if (validate) {
                final sendEmail = await _inspectionSendRepository
                    .sendEmailInspection(inspectionIdField);
                sendEmail.fold(
                  (Failure failure) => setState(InspectionSendViewState.error),
                  (bool sendEmail) {
                    sendEmail
                        ? setState(InspectionSendViewState.completed)
                        : setState(InspectionSendViewState.error);
                  },
                );
              } else {
                setState(InspectionSendViewState.error);
              }
            },
          );
        } else {
          setState(InspectionSendViewState.error);
        }
      },
    );
  }

  Future<List<ParameterInspection>?> _getParameters() async {
    List<ParameterInspection> listParameters = [];
    final responseLocal =
        await _inspectionCheckRepository.getParameters('parametersInspection');

    responseLocal.fold(
      (failure) => null,
      (List<ParameterInspection>? listImage) {
        if (listImage == null) {
          listParameters = [];
        } else {
          listParameters = listImage;
        }
      },
    );
    return listParameters;
  }

  Future<List<InspectionPerson>?> _getPersons() async {
    List<InspectionPerson> list = [];
    final response =
        await _inspectionPersonRepository.getPersons(InspectionPerson.id);
    response.fold(
      (failure) => null,
      (List<InspectionPerson>? personList) {
        if (personList == null) {
          list = [];
        } else {
          list = personList;
        }
      },
    );
    return list;
  }

  Future<List<InspectionImage>?> _getImages() async {
    List<InspectionImage> listImages = [];
    final response =
        await _inspectionImageRepository.getImages(InspectionImage.id);
    response.fold(
      (failure) => null,
      (List<InspectionImage>? listImage) {
        if (listImage == null) {
          listImages = [];
        } else {
          listImages = listImage;
        }
      },
    );
    return listImages;
  }
}
