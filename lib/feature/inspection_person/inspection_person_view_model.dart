import 'package:safecty/core/mvvm/base_view_model.dart';
import 'package:safecty/model/repository/inspection_person/inspection_person.dart';
import 'package:safecty/model/repository/model/dropdown_type.dart';
import 'package:safecty/model/repository/model/inspection_person.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';
import 'package:safecty/model/repository/model/work_center.dart';
import 'package:safecty/model/storage/secure_storage.dart';

enum InspectionPersonViewState {
  completed,
  error,
  initial,
  loading,
  loadingSaved,
  completedSaved,
  data,
}

class InspectionPersonViewModel
    extends BaseViewModel<InspectionPersonViewState> {
  InspectionPersonViewModel({
    required InspectionPersonRepository inspectionPersonRepository,
    required SecureStorage secureStorage,
  })  : _inspectionPersonRepository = inspectionPersonRepository,
        _secureStorage = secureStorage;

  final InspectionPersonRepository _inspectionPersonRepository;
  final SecureStorage _secureStorage;

  List<InspectionPerson>? _listPerson;
  List<InspectionPerson>? _selectPerson;
  List<ParameterInspection>? _listParameters;
  final List<DropDownType> _personDropDownType = [];

  List<InspectionPerson>? get listPerson => _listPerson;
  List<InspectionPerson>? get selectPersons => _selectPerson;
  List<ParameterInspection>? get listParameters => _listParameters;
  List<DropDownType> get personDropDownType => _personDropDownType;

  void init() => super.initialize(InspectionPersonViewState.initial);

  Future<void> getParameters() async {
    setState(InspectionPersonViewState.loading);
    final response =
        await _inspectionPersonRepository.getParameters('parametersInspection');

    response.fold(
      (failure) => setState(InspectionPersonViewState.error),
      (List<ParameterInspection>? listImage) async {
        if (listImage != null || listImage!.isNotEmpty) {
          _listParameters = listImage;
          setState(InspectionPersonViewState.completed);
        } else {
          setState(InspectionPersonViewState.error);
        }
      },
    );
  }

  Future<void> getPersonsSelect() async {
    setState(InspectionPersonViewState.loading);
    final response =
        await _inspectionPersonRepository.getPersons(InspectionPerson.id);

    response.fold(
      (failure) => setState(InspectionPersonViewState.error),
      (List<InspectionPerson>? personList) async {
        if (personList != null || personList!.isNotEmpty) {
          _selectPerson = personList;
          setState(InspectionPersonViewState.completed);
        } else {
          setState(InspectionPersonViewState.error);
        }
      },
    );
  }

  Future<void> savedPerson(List<InspectionPerson> listPerson) async {
    setState(InspectionPersonViewState.loading);
    final response = await _inspectionPersonRepository.savedPersons(listPerson);

    response.fold(
      (failure) => setState(InspectionPersonViewState.error),
      (bool? listParameters) async {
        if (listParameters!) {
          setState(InspectionPersonViewState.completed);
        } else {
          setState(InspectionPersonViewState.error);
        }
      },
    );
  }

  Future<void> getPerson() async {
    setState(InspectionPersonViewState.loading);
    WorkCenter? workCenter = await _secureStorage.getWorkCenter();

    if (workCenter == null) {
      setState(InspectionPersonViewState.error);
    }

    final response =
        await _inspectionPersonRepository.getPersonUrl(workCenter!.companyId);

    response.fold(
      (failure) => setState(InspectionPersonViewState.error),
      (List<InspectionPerson>? listPerson) async {
        if (listPerson == null) {
          setState(InspectionPersonViewState.error);
        }
        _personDropDownType.addAll(
          listPerson!.map(
            (e) => DropDownType(e.personId.toString(),
                '${e.professionalName} ${e.professionalSurname}'),
          ),
        );
        _listPerson = listPerson;
        setState(InspectionPersonViewState.completed);
      },
    );
  }
}
