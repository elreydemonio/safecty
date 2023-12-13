import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:safecty/core/app/app_exception.dart';
import 'package:safecty/model/endpoints.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/client/network_client.dart';
import 'package:safecty/model/repository/client/server_exception.dart';
import 'package:safecty/model/repository/login/login_repository_impl.dart';
import 'package:safecty/model/repository/model/user.dart';

class LoginRepositoryImpl extends LoginRepository {
  LoginRepositoryImpl({
    required endpoints,
    required networkClient,
  })  : _endpoints = endpoints,
        _networkClient = networkClient;

  final Endpoints _endpoints;
  final NetworkClient _networkClient;

  @override
  Future<Either<Failure, User?>> loginUser(String user, String password) async {
    try {
      final String urlLogin =
          "${_endpoints.login}(idpersona='$user',passwd='$password')";
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
          List<User> userList =
              userListJson.map((userJson) => User.fromJson(userJson)).toList();
          return Right(userList.first);
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
