import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:safecty/core/app/app_exception.dart';
import 'package:safecty/model/endpoints.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/client/network_client.dart';
import 'package:safecty/model/repository/client/server_exception.dart';
import 'package:safecty/model/repository/inspection_person/inspection_person.dart';
import 'package:safecty/model/repository/model/inspection_person.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';
import 'package:safecty/model/storage/local_storage.dart';

class InspectionPersonRepositoryImpl extends InspectionPersonRepository {
  InspectionPersonRepositoryImpl({
    required localStorage,
    required endpoints,
    required networkClient,
  })  : _localStorage = localStorage,
        _endpoints = endpoints,
        _networkClient = networkClient;

  final LocalStorage _localStorage;
  final Endpoints _endpoints;
  final NetworkClient _networkClient;

  @override
  Future<Either<Failure, List<InspectionPerson>?>> getPersonUrl(
    int workCenterId,
  ) async {
    try {
      final String personUrl =
          "${_endpoints.person}(strCedula=null,idCentroTrabajo=$workCenterId)";
      final response = await _networkClient.get(
        Uri.parse(
          join(_endpoints.baseUrlGet, personUrl),
        ),
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode >= HttpStatus.badRequest) {
        throw ServerException();
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey("value")) {
        final List<dynamic> personJson = jsonDecode(jsonResponse["value"]);
        if (personJson.isNotEmpty) {
          List<InspectionPerson> personList = personJson
              .map((areaJson) => InspectionPerson.fromMap(areaJson))
              .toList();
          return Right(personList);
        }
      }
      return const Right(<InspectionPerson>[]);
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
  Future<Either<Failure, List<ParameterInspection>?>> getParameters(
    String parameterId,
  ) async {
    try {
      final listParameters = await _localStorage.getListParameters(parameterId);
      return Right(listParameters);
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
  Future<Either<Failure, bool?>> savedPersons(
    List<InspectionPerson> listPerson,
  ) async {
    try {
      final email = await _localStorage.storeListPerson(listPerson);
      return Right(email);
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
  Future<Either<Failure, List<InspectionPerson>?>> getPersons(
    String personId,
  ) async {
    try {
      final listParameters = await _localStorage.getPersons(personId);
      return Right(listParameters);
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
