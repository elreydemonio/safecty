import 'package:safecty/core/mvvm/base_view_model.dart';
import 'package:safecty/model/repository/inspection_plan/inspection_plan.dart';
import 'package:safecty/model/repository/model/area.dart';
import 'package:safecty/model/repository/model/dropdown_type.dart';
import 'package:safecty/model/repository/model/inspection.dart';
import 'package:safecty/model/repository/model/inspection_plan_pending.dart';
import 'package:safecty/model/repository/model/risk.dart';
import 'package:safecty/model/repository/model/user.dart';
import 'package:safecty/model/repository/model/work_center.dart';
import 'package:safecty/model/storage/secure_storage.dart';

enum InspectionPlanViewState {
  completed,
  error,
  initial,
  loading,
  loadingInspection,
  completedInspection,
  completedStore,
}

class InspectionPlanViewModel extends BaseViewModel<InspectionPlanViewState> {
  InspectionPlanViewModel({
    required InspectionPlanRepository inspectionPlanRepository,
    required SecureStorage secureStorage,
  })  : _inspectionPlanRepository = inspectionPlanRepository,
        _secureStorage = secureStorage;

  final InspectionPlanRepository _inspectionPlanRepository;
  final SecureStorage _secureStorage;

  String? valueZone;
  String? risk;
  String? inspectionValue;

  List<Inspection>? _inspections;
  List<Area>? _areas;
  List<Risk>? _risks;
  InspectionsPlanPending? _inspectionsPlanPending;
  final List<DropDownType> _areaList = [];
  final List<DropDownType> _riskList = [];
  List<DropDownType>? _inspectionList;

  InspectionsPlanPending? get inspectionsPlanPending => _inspectionsPlanPending;

  List<DropDownType>? get areaList => _areaList;
  List<DropDownType>? get riskList => _riskList;
  List<DropDownType>? get inspectionList => _inspectionList;

  void init() => super.initialize(InspectionPlanViewState.initial);

  Future<void> getInspections() async {
    setState(InspectionPlanViewState.loading);
    User? user = await _secureStorage.getUser();
    WorkCenter? workCenter = await _secureStorage.getWorkCenter();

    final response = await _inspectionPlanRepository.getInspections(
      user!.identificationCard,
      workCenter!.companyId,
    );

    response.fold(
      (failure) => setState(InspectionPlanViewState.error),
      (InspectionsPlanPending? inspectionsPlanPending) {
        if (inspectionsPlanPending == null) {
          setState(InspectionPlanViewState.error);
        }
        _inspectionsPlanPending = inspectionsPlanPending;
        setState(InspectionPlanViewState.completed);
      },
    );
  }

  Future<void> getArea() async {
    setState(InspectionPlanViewState.loading);
    WorkCenter? workCenter = await _secureStorage.getWorkCenter();

    final response = await _inspectionPlanRepository.getArea(
      workCenter!.companyId,
    );

    response.fold(
      (failure) => setState(InspectionPlanViewState.error),
      (List<Area>? area) {
        if (area == null) {
          setState(InspectionPlanViewState.error);
        }
        _areas = area;
        _areaList.addAll(
          area!.map(
            (e) => DropDownType(e.areaId.toString(), e.description),
          ),
        );
        setState(InspectionPlanViewState.completed);
      },
    );
  }

  Future<void> savedConfig() async {
    setState(InspectionPlanViewState.loading);
    Inspection inspection = _inspections!.firstWhere(
      (element) => element.inspectionId == int.parse(inspectionValue!),
    );
    Area area = _areas!.firstWhere(
      (element) => element.areaId == int.parse(valueZone!),
    );
    Risk riskFirst = _risks!.firstWhere(
      (element) => element.riskId == int.parse(risk!),
    );
    await _secureStorage.storeInspection(inspection);
    await _secureStorage.storeArea(area);
    await _secureStorage.storeRisk(riskFirst);
    setState(InspectionPlanViewState.completedStore);
  }

  Future<void> getRisk() async {
    setState(InspectionPlanViewState.loading);
    WorkCenter? workCenter = await _secureStorage.getWorkCenter();

    final response = await _inspectionPlanRepository.getRisk(
      workCenter!.companyId,
    );

    response.fold(
      (failure) => setState(InspectionPlanViewState.error),
      (List<Risk>? risk) {
        if (risk == null) {
          setState(InspectionPlanViewState.error);
        }
        _risks = risk;
        _riskList.addAll(
          risk!.map(
            (e) => DropDownType(e.riskId.toString(), e.description),
          ),
        );
        setState(InspectionPlanViewState.completed);
      },
    );
  }

  Future<void> getInspectionList(int riskId) async {
    setState(InspectionPlanViewState.loadingInspection);
    WorkCenter? workCenter = await _secureStorage.getWorkCenter();

    final response = await _inspectionPlanRepository.getInspectionsByRisk(
      riskId: riskId,
      workCenterId: workCenter!.companyId,
    );

    response.fold(
      (failure) => setState(InspectionPlanViewState.error),
      (List<Inspection>? inspection) {
        if (inspection == null) {
          setState(InspectionPlanViewState.error);
        }
        _inspections = inspection!;
        _inspectionList = [];
        _inspectionList!.addAll(
          inspection.map(
            (e) => DropDownType(
              e.inspectionId.toString(),
              e.descriptionInspection,
            ),
          ),
        );
        setState(InspectionPlanViewState.completedInspection);
      },
    );
  }
}
