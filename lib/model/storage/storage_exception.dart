import 'package:safecty/core/app/app_error.dart';
import 'package:safecty/core/app/app_exception.dart';

class StorageException extends AppException {
  StorageException({
    String? message,
  }) : super(message: message);

  @override
  AppError get error => AppError.storageError;
}
