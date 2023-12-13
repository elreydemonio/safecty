import 'package:safecty/core/app/app_error.dart';
import 'package:safecty/core/app/app_exception.dart';

class ServerException extends AppException {
  ServerException({
    super.message,
  });

  @override
  AppError get error => AppError.serverError;
}
