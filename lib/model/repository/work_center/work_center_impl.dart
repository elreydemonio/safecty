import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:safecty/core/app/app_exception.dart';
import 'package:safecty/model/endpoints.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/client/network_client.dart';
import 'package:safecty/model/repository/client/server_exception.dart';
import 'package:safecty/model/repository/model/work_center.dart';
import 'package:safecty/model/repository/work_center/work_center.dart';

class WorkCenterRepositoryImpl extends WorkCenterRepository {
  WorkCenterRepositoryImpl({
    required endpoints,
    required networkClient,
  })  : _endpoints = endpoints,
        _networkClient = networkClient;

  final Endpoints _endpoints;
  final NetworkClient _networkClient;

  @override
  Future<Either<Failure, List<WorkCenter>?>> getWorkCenter(
      String identificationCard) async {
    try {
      final String urlLogin =
          "${_endpoints.workCenter}(strCedula='$identificationCard')";
      final response = await _networkClient.get(
        Uri.parse(
          join(_endpoints.baseUrlGet, urlLogin),
        ),
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode >= HttpStatus.badRequest) {
        throw ServerException();
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey("value")) {
        final List<dynamic> userListJson = jsonDecode(jsonResponse["value"]);
        if (userListJson.isNotEmpty) {
          List<WorkCenter> workCenterList = userListJson
              .map((userJson) => WorkCenter.fromMap(userJson))
              .toList();
          return Right(workCenterList);
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
