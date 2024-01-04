import 'package:dartz/dartz.dart';
import 'package:safecty/core/app/app_exception.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/inspection_image/inspection_image.dart';
import 'package:safecty/model/repository/model/inspection_image.dart';
import 'package:safecty/model/storage/local_storage.dart';

class InspectionImageRepositoryImpl extends InspectionImageRepository {
  InspectionImageRepositoryImpl({
    required localStorage,
  }) : _localStorage = localStorage;
  final LocalStorage _localStorage;

  @override
  Future<Either<Failure, bool?>> savedImage(
    List<InspectionImage> listImage,
  ) async {
    try {
      final email = await _localStorage.storeListImages(listImage);
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
  Future<Either<Failure, List<InspectionImage>?>> getImages(
    String imageId,
  ) async {
    try {
      final listImage = await _localStorage.getListImage(imageId);
      return Right(listImage);
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
