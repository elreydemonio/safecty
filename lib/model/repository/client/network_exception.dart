import '../../../core/app/app_error.dart';
import '../../../core/app/app_exception.dart';

class NetworkException extends AppException {
  NetworkException({
    String? message,
  }) : super(message: message);

  @override
  AppError get error => AppError.networkError;
}
