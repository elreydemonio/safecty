import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:path/path.dart';
import 'package:safecty/core/app/app_exception.dart';
import 'package:safecty/model/endpoints.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/client/network_client.dart';
import 'package:safecty/model/repository/client/server_exception.dart';
import 'package:safecty/model/repository/inspection_send/inspection_send.dart';
import 'package:safecty/model/repository/model/area.dart';
import 'package:safecty/model/repository/model/inspection.dart';
import 'package:safecty/model/repository/model/inspection_image.dart';
import 'package:safecty/model/repository/model/inspection_person.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';
import 'package:safecty/model/repository/model/post/evidence_inspection.dart';
import 'package:safecty/model/repository/model/post/inspection_send.dart';
import 'package:safecty/model/repository/model/post/person_signature.dart';
import 'package:safecty/model/repository/model/user.dart';
import 'package:safecty/model/storage/local_storage.dart';

class InspectionSendRepositoryImpl extends InspectionSendRepository {
  InspectionSendRepositoryImpl({
    required endpoints,
    required networkClient,
    required localStorage,
  })  : _endpoints = endpoints,
        _networkClient = networkClient,
        _localStorage = localStorage;

  final Endpoints _endpoints;
  final NetworkClient _networkClient;
  final LocalStorage _localStorage;

  @override
  Future<Either<Failure, bool>> savedEvidence(
    List<InspectionImage> listEvidence,
    int inspectionId,
  ) async {
    try {
      final String savedEvidence = _endpoints.savedEvidence;

      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8'
      };

      for (var evidence in listEvidence) {
        List<int> fileBytes = await evidence.file.readAsBytes();
        String base64String = base64Encode(fileBytes);
        final response = await _networkClient.post(
          Uri.parse(
            join(_endpoints.baseUrlPost, savedEvidence),
          ),
          headers: headers,
          body: EvidenceInspection(
                  base64: base64String, inspectionId: inspectionId)
              .toMap(),
        );

        if (response.statusCode < HttpStatus.ok ||
            response.statusCode >= HttpStatus.badRequest) {
          throw ServerException();
        }

        if (response.body.replaceAll('"', '').toLowerCase() != "true") {
          throw ServerException();
        }
      }

      return const Right(true);
    } on AppException catch (ae) {
      return Left(
        Failure(
          error: ae.error,
          description: ae.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> savedInspection({
    required Inspection inspection,
    required List<ParameterInspection> listParameters,
    required Area area,
    required User user,
    required List<InspectionImage> listEvidence,
  }) async {
    try {
      final String savedInspection = _endpoints.savedInspection;

      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8'
      };

      String observations = listEvidence
          .asMap()
          .entries
          .map((entry) =>
              "${entry.key + 1}) ${entry.value.description ?? 'Sin obeservacion'}")
          .join(', ');

      List<Parameter> parameters = [];

      for (var parameter in listParameters) {
        Parameter parameterSend = Parameter(
          bitCumple: parameter.isCheck!,
          dtfecuser: false,
          id: 0,
          intIdInspeccion: inspection.inspectionId.toString(),
          intIdInspeccionFk: 0,
          idParametro: parameter.parameterId.toString(),
          intIdRiesgo: inspection.riskId.toString(),
          strDescripcionParametro: parameter.descriptionParameter,
        );
        parameters.add(parameterSend);
      }

      final InspectionSend inspectionSed = InspectionSend(
        id: 0,
        inspectionName: inspection.descriptionInspection,
        intIdArea: area.areaId,
        idCentroTrabajo: inspection.companyId,
        idInspeccion: inspection.inspectionId,
        idRiesgo: inspection.riskId,
        isPositive:
            listParameters.any((element) => element.isCheck == false) ? 1 : 0,
        observacion: observations,
        idUsuario: user.identificationCard,
      );

      final String parametersJson =
          "[${parameters.map((p) => p.toJson()).join(',')}]";

      final response = await _networkClient.post(
          Uri.parse(
            join(_endpoints.baseUrlPost, savedInspection),
          ),
          headers: headers,
          body: "${inspectionSed.toJson()}|$parametersJson");

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode >= HttpStatus.badRequest) {
        throw ServerException();
      }

      return Right(response.body);
    } on AppException catch (ae) {
      return Left(
        Failure(
          error: ae.error,
          description: ae.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> savedSignature({
    required List<InspectionPerson> personSignature,
    required int fieldInspectionId,
    required int workCenterId,
  }) async {
    try {
      final String savedSignature = _endpoints.savedSignature;

      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8'
      };

      for (var signature in personSignature) {
        String? base64String = "";
        if (signature.file == null) {
          base64String = null;
        } else {
          List<int> fileBytes = await signature.file!.readAsBytes();
          base64String = base64Encode(fileBytes);
        }

        final response = await _networkClient.post(
          Uri.parse(
            join(_endpoints.baseUrlPost, savedSignature),
          ),
          headers: headers,
          body: PersonSignature(
            base64: base64String,
            identificationCard: signature.identificationCard,
            fieldInspectionId: fieldInspectionId,
            workCenterId: workCenterId,
          ).toMap(),
        );

        if (response.statusCode < HttpStatus.ok ||
            response.statusCode >= HttpStatus.badRequest) {
          throw ServerException();
        }

        if (response.body.replaceAll('"', '').toLowerCase() != "true") {
          throw ServerException();
        }
      }

      return const Right(true);
    } on AppException catch (ae) {
      return Left(
        Failure(
          error: ae.error,
          description: ae.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> sendEmailInspection(int inspectionId) async {
    try {
      final String savedInspection =
          "${_endpoints.sendEmail}(idInspeccion=$inspectionId)";

      final response = await _networkClient.get(
        Uri.parse(
          join(_endpoints.baseUrlEmail, savedInspection),
        ),
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode >= HttpStatus.badRequest) {
        throw ServerException();
      }

      return const Right(true);
    } on AppException catch (ae) {
      return Left(
        Failure(
          error: ae.error,
          description: ae.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> validateInspection(int inspectionId) async {
    try {
      final String savedInspection =
          "${_endpoints.validateInspection}?idInspeccion=$inspectionId";

      final response = await _networkClient.post(
        Uri.parse(
          join(_endpoints.baseUrlPost, savedInspection),
        ),
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode >= HttpStatus.badRequest) {
        throw ServerException();
      }

      return Right(response.body.replaceAll('"', '').toLowerCase() == "true");
    } on AppException catch (ae) {
      return Left(
        Failure(
          error: ae.error,
          description: ae.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> deleteEvidence(String imageId) async {
    try {
      final delete = await _localStorage.deleteEvidences(imageId);
      return Right(delete);
    } on AppException catch (ae) {
      return Left(
        Failure(
          error: ae.error,
          description: ae.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> deletePerson(String personsId) async {
    try {
      final delete = await _localStorage.deletePersons(personsId);
      return Right(delete);
    } on AppException catch (ae) {
      return Left(
        Failure(
          error: ae.error,
          description: ae.message,
        ),
      );
    }
  }
}
