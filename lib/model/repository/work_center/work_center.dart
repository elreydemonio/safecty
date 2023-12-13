import 'package:dartz/dartz.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/model/work_center.dart';

abstract class WorkCenterRepository {
  Future<Either<Failure, List<WorkCenter>?>> getWorkCenter(
      String identificationCard);
}
