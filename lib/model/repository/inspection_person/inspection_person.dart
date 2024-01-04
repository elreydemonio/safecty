import 'package:dartz/dartz.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/model/inspection_person.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';

abstract class InspectionPersonRepository {
  Future<Either<Failure, List<InspectionPerson>?>> getPersonUrl(
    int workCenterId,
  );

  Future<Either<Failure, List<ParameterInspection>?>> getParameters(
    String parameterId,
  );

  Future<Either<Failure, List<InspectionPerson>?>> getPersons(
    String parameterId,
  );

  Future<Either<Failure, bool?>> savedPersons(
    List<InspectionPerson> listPerson,
  );
}
