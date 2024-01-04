import 'package:dartz/dartz.dart';
import 'package:safecty/model/failure.dart';
import 'package:safecty/model/repository/model/inspection_image.dart';

abstract class InspectionImageRepository {
  Future<Either<Failure, bool?>> savedImage(List<InspectionImage> listImage);
  Future<Either<Failure, List<InspectionImage>?>> getImages(String imageId);
}
