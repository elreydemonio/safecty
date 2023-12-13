import 'package:safecty/core/mvvm/base_view_model.dart';
import 'package:safecty/model/repository/model/work_center.dart';
import 'package:safecty/model/repository/work_center/work_center.dart';
import 'package:safecty/model/storage/secure_storage.dart';

enum WorkCenterViewState {
  completed,
  completedStore,
  error,
  initial,
  loading,
}

class WorkCenterViewModel extends BaseViewModel<WorkCenterViewState> {
  WorkCenterViewModel({
    required WorkCenterRepository workCenterRepository,
    required SecureStorage secureStorage,
  })  : _workCenterRepository = workCenterRepository,
        _secureStorage = secureStorage;

  final WorkCenterRepository _workCenterRepository;
  final SecureStorage _secureStorage;

  List<WorkCenter>? _workCenterList;

  List<WorkCenter>? get workCenterList => _workCenterList;

  void init() => super.initialize(WorkCenterViewState.initial);

  Future<void> getWorkCenter(String identificationCard) async {
    setState(WorkCenterViewState.loading);
    final response =
        await _workCenterRepository.getWorkCenter(identificationCard);

    response.fold(
      (failure) => setState(WorkCenterViewState.error),
      (List<WorkCenter>? workCenterList) async {
        if (workCenterList == null) {
          setState(WorkCenterViewState.error);
        }
        _workCenterList = workCenterList;
        setState(WorkCenterViewState.completed);
      },
    );
  }

  Future<void> savedWorkCenterId(WorkCenter workCenter) async {
    setState(WorkCenterViewState.loading);
    await _secureStorage.storeWorkCenterId(workCenter);
    setState(WorkCenterViewState.completedStore);
  }
}
