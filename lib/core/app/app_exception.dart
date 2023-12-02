import 'app_error.dart';

abstract class AppException implements Exception {
  const AppException({
    this.message,
  });

  final String? message;

  AppError get error;
}
