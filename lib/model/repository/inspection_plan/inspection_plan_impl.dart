import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:safecty/core/app/app_exception.dart';
import 'package:safecty/model/endpoints.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/client/network_client.dart';
import 'package:safecty/model/repository/client/server_exception.dart';
import 'package:safecty/model/repository/inspection_plan/inspection_plan.dart';
import 'package:safecty/model/repository/model/area.dart';
import 'package:safecty/model/repository/model/chart_inspction_plan.dart';
import 'package:safecty/model/repository/model/inspection.dart';
import 'package:safecty/model/repository/model/inspection_plan_pending.dart';
import 'package:safecty/model/repository/model/inspection_plan_table.dart';
import 'package:safecty/model/repository/model/risk.dart';

class InspectionPlanRepositoryImpl extends InspectionPlanRepository {
  InspectionPlanRepositoryImpl({
    required endpoints,
    required networkClient,
  })  : _endpoints = endpoints,
        _networkClient = networkClient;

  final Endpoints _endpoints;
  final NetworkClient _networkClient;

  @override
  Future<Either<Failure, InspectionsPlanPending?>> getInspections(
    String identificationCard,
    int workCenterId,
  ) async {
    try {
      DateTime now = DateTime.now();
      int month = now.month;
      int year = now.year;

      final String urlInspections =
          "${_endpoints.inspectionsPlanPending}(idWorkCenter=$workCenterId,username='$identificationCard',month=$month,year=$year)";
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
        final Map<String, dynamic> tables = jsonDecode(jsonResponse["value"]);
        if (tables.isNotEmpty) {
          List<InspectionPlanTable> listTable = [];
          List<CharInspectionPlan> char = [];
          tables["Table"]
              .map((x) => listTable.add(InspectionPlanTable.fromMap(x)))
              .toList();
          tables["Table1"]
              .map((x) => char.add(CharInspectionPlan.fromMap(x)))
              .toList();
          return Right(
            InspectionsPlanPending(
              charInspection: char.first,
              listInspection: listTable,
            ),
          );
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

  @override
  Future<Either<Failure, List<Area>?>> getArea(int workCenterId) async {
    try {
      final String area = "${_endpoints.area}(idCentroTrabajo=$workCenterId)";
      final response = await _networkClient.get(
        Uri.parse(
          join(_endpoints.baseUrlGet, area),
        ),
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode >= HttpStatus.badRequest) {
        throw ServerException();
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey("value")) {
        final List<dynamic> area = jsonDecode(jsonResponse["value"]);
        if (area.isNotEmpty) {
          List<Area> areaList =
              area.map((areaJson) => Area.fromMap(areaJson)).toList();
          return Right(areaList);
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

  @override
  Future<Either<Failure, List<Inspection>?>> getInspectionsByRisk({
    required int workCenterId,
    required int riskId,
  }) async {
    try {
      final String area =
          "${_endpoints.inspection}(idCentroTrabajo=$workCenterId,idRiesgo=$riskId)";
      final response = await _networkClient.get(
        Uri.parse(
          join(_endpoints.baseUrlGet, area),
        ),
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode >= HttpStatus.badRequest) {
        throw ServerException();
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey("value")) {
        final List<dynamic> inspection = jsonDecode(jsonResponse["value"]);
        if (area.isNotEmpty) {
          List<Inspection> inspectionList = inspection
              .map((inspectionJson) => Inspection.fromMap(inspectionJson))
              .toList();
          return Right(inspectionList);
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

  @override
  Future<Either<Failure, List<Risk>?>> getRisk(int workCenterId) async {
    try {
      final String area = "${_endpoints.risks}(idCentroTrabajo=$workCenterId)";
      final response = await _networkClient.get(
        Uri.parse(
          join(_endpoints.baseUrlGet, area),
        ),
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode >= HttpStatus.badRequest) {
        throw ServerException();
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey("value")) {
        final List<dynamic> risk = jsonDecode(jsonResponse["value"]);
        if (risk.isNotEmpty) {
          List<Risk> riskList =
              risk.map((riskJson) => Risk.fromMap(riskJson)).toList();
          return Right(riskList);
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
