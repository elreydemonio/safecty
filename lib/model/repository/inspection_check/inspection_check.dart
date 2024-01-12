import 'package:dartz/dartz.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';

abstract class InspectionCheckRepository {
  Future<Either<Failure, List<ParameterInspection>?>> getParameter(
    int inspectionId,
  );

  Future<Either<Failure, bool?>> savedParameters(
    List<ParameterInspection> listParameters,
  );

  Future<Either<Failure, List<ParameterInspection>?>> getParameters(
    String parameterId,
  );

  Future<Either<Failure, bool?>> deletePerson(String personId);
}
