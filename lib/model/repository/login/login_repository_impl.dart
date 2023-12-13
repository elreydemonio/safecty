import 'package:dartz/dartz.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/model/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User?>> loginUser(String user, String password);
}
