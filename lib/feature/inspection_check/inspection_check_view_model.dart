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

    final response = await _inspectionCheckRepository
        .getParameter(_inspection!.inspectionId);

    response.fold(
      (failure) => setState(InspectionCheckViewState.error),
      (List<ParameterInspection>? listParameters) async {
        if (listParameters == null) {
          setState(InspectionCheckViewState.error);
        }
        _listParameters = listParameters;
        setState(InspectionCheckViewState.completed);
      },
    );
  }
}
