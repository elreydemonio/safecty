import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:safecty/core/app/app_exception.dart';
import 'package:safecty/model/endpoints.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/client/network_client.dart';
import 'package:safecty/model/repository/client/server_exception.dart';
import 'package:safecty/model/repository/inspection_check/inspection_check.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';

class InspectionCheckRepositoryImpl extends InspectionCheckRepository {
  InspectionCheckRepositoryImpl({
    required endpoints,
    required networkClient,
  })  : _endpoints = endpoints,
        _networkClient = networkClient;

  final Endpoints _endpoints;
  final NetworkClient _networkClient;

  @override
  Future<Either<Failure, List<ParameterInspection>?>> getParameter(
    int inspectionId,
  ) async {
    try {
      final String urlInspections =
          "${_endpoints.parameter}(idCentroTrabajo=null,idInspeccion=$inspectionId)";
      final response = await _networkClient.get(
        Uri.parse(
          join(_endpoints.baseUrlGet, urlInspections),
        ),
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode >= HttpStatus.badRequest) {
        throw ServerException();
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey("value")) {
        final List<dynamic> json = jsonDecode(jsonResponse["value"]);
        if (json.isNotEmpty) {
          List<ParameterInspection> parameterList = json
              .map(
                  (parameterJson) => ParameterInspection.fromMap(parameterJson))
              .toList();
          return Right(parameterList);
        }
      }

      throw const FormatException('Respuesta del servidor no es válida.');
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
