import 'package:safecty/core/mvvm/base_view_model.dart';
import 'package:safecty/model/repository/inspection_check/inspection_check.dart';
import 'package:safecty/model/repository/model/area.dart';
import 'package:safecty/model/repository/model/inspection.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';
import 'package:safecty/model/repository/model/risk.dart';
import 'package:safecty/model/storage/secure_storage.dart';

enum InspectionCheckViewState {
  completed,
  error,
  initial,
  loading,
  loadingSaved,
  completedSaved,
  data,
}

class InspectionCheckViewModel extends BaseViewModel<InspectionCheckViewState> {
  InspectionCheckViewModel({
    required InspectionCheckRepository inspectionCheckRepository,
    required SecureStorage secureStorage,
  })  : _inspectionCheckRepository = inspectionCheckRepository,
        _secureStorage = secureStorage;

  final InspectionCheckRepository _inspectionCheckRepository;
  final SecureStorage _secureStorage;

  Inspection? _inspection;
  Risk? _risk;
  Area? _area;
  List<ParameterInspection>? _listParameters;

  Inspection? get inspection => _inspection;
  Risk? get risk => _risk;
  Area? get area => _area;
  List<ParameterInspection>? get listParameters => _listParameters;

  void init() => super.initialize(InspectionCheckViewState.initial);

  Future<void> getParameter() async {
    setState(InspectionCheckViewState.loading);
    _inspection = await _secureStorage.getInspection();
    _area = await _secureStorage.getArea();
    _risk = await _secureStorage.getRisk();

    if (_inspection == null) {
      setState(InspectionCheckViewState.error);
    }

    final responseLocal =
        await _inspectionCheckRepository.getParameters('parametersInspection');

    responseLocal.fold(
      (failure) => setState(InspectionCheckViewState.error),
      (List<ParameterInspection>? listParameters) async {
        if (listParameters != null || listParameters!.isEmpty) {
          if (listParameters[0].inspectionId == _inspection!.inspectionId) {
            _listParameters = listParameters;
            setState(InspectionCheckViewState.completed);
          } else {
            final responseList = await _getParameterUrl();
            if (responseList == null) {
              setState(InspectionCheckViewState.error);
            }
            _listParameters = responseList;
            _isCheckAll(inspection!.parameters);
            setState(InspectionCheckViewState.completed);
          }
        } else {
          final responseList = await _getParameterUrl();
          if (responseList == null) {
            setState(InspectionCheckViewState.error);
          }
          _listParameters = responseList;
          _isCheckAll(inspection!.parameters);
          setState(InspectionCheckViewState.completed);
        }
      },
    );
  }

  void _isCheckAll(bool parameter) {
    for (var obj in _listParameters!) {
      obj.isCheck = parameter;
    }
  }

  Future<List<ParameterInspection>?> _getParameterUrl() async {
    final response = await _inspectionCheckRepository
        .getParameter(_inspection!.inspectionId);

    return response.fold(
      (failure) {
        return null;
      },
      (List<ParameterInspection>? listParameters) {
        return listParameters;
      },
    );
  }

  Future<void> saveParameters(List<ParameterInspection> listParameters) async {
    setState(InspectionCheckViewState.loadingSaved);
    final response =
        await _inspectionCheckRepository.savedParameters(listParameters);

    response.fold(
      (failure) => setState(InspectionCheckViewState.error),
      (bool? listParameters) async {
        if (listParameters!) {
          setState(InspectionCheckViewState.completedSaved);
        } else {
          setState(InspectionCheckViewState.error);
        }
      },
    );
  }
}
