import 'package:dartz/dartz.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/model/area.dart';
import 'package:safecty/model/repository/model/inspection.dart';
import 'package:safecty/model/repository/model/inspection_plan_pending.dart';
import 'package:safecty/model/repository/model/risk.dart';

abstract class InspectionPlanRepository {
  Future<Either<Failure, InspectionsPlanPending?>> getInspections(
    String identificationCard,
    int workCenterId,
  );

  Future<Either<Failure, List<Risk>?>> getRisk(int workCenterId);

  Future<Either<Failure, List<Area>?>> getArea(int workCenterId);

  Future<Either<Failure, List<Inspection>?>> getInspectionsByRisk({
    required int workCenterId,
    required int riskId,
  });
}
