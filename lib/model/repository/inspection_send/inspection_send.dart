import 'package:dartz/dartz.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/model/area.dart';
import 'package:safecty/model/repository/model/inspection.dart';
import 'package:safecty/model/repository/model/inspection_image.dart';
import 'package:safecty/model/repository/model/inspection_person.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';
import 'package:safecty/model/repository/model/user.dart';

abstract class InspectionSendRepository {
  Future<Either<Failure, String>> savedInspection({
    required Inspection inspection,
    required List<ParameterInspection> listParameters,
    required Area area,
    required User user,
    required List<InspectionImage> listEvidence,
  });

  Future<Either<Failure, bool>> savedSignature({
    required List<InspectionPerson> personSignature,
    required int fieldInspectionId,
    required int workCenterId,
  });

  Future<Either<Failure, bool>> savedEvidence(
    List<InspectionImage> listEvidence,
    int inspectionId,
  );

  Future<Either<Failure, bool>> validateInspection(int inspectionId);

  Future<Either<Failure, bool>> sendEmailInspection(int inspectionId);
}
