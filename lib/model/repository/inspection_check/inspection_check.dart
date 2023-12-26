import 'package:dartz/dartz.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';

abstract class InspectionCheckRepository {
  Future<Either<Failure, List<ParameterInspection>?>> getParameter(
    int inspectionId,
  );
}
