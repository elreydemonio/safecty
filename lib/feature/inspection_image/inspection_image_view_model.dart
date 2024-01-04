import 'package:safecty/core/mvvm/base_view_model.dart';
import 'package:safecty/model/repository/inspection_image/inspection_image.dart';
import 'package:safecty/model/repository/model/inspection_image.dart';

enum InspectionImageViewState {
  completed,
  error,
  initial,
  loading,
  data,
  incomplete,
}

class InspectionImageViewModel extends BaseViewModel<InspectionImageViewState> {
  InspectionImageViewModel({
    required InspectionImageRepository inspectionImageRepository,
  }) : _inspectionImageRepository = inspectionImageRepository;

  final InspectionImageRepository _inspectionImageRepository;

  List<InspectionImage>? listImages;

  void init() => super.initialize(InspectionImageViewState.initial);

  Future<void> saveImages(List<InspectionImage> listImages) async {
    setState(InspectionImageViewState.loading);
    final response = await _inspectionImageRepository.savedImage(listImages);

    response.fold(
      (failure) => setState(InspectionImageViewState.error),
      (bool? listParameters) async {
        if (listParameters!) {
          setState(InspectionImageViewState.completed);
        } else {
          setState(InspectionImageViewState.error);
        }
      },
    );
  }

  Future<void> getImages() async {
    setState(InspectionImageViewState.loading);
    final response =
        await _inspectionImageRepository.getImages('InspectionImages');

    response.fold(
      (failure) => setState(InspectionImageViewState.error),
      (List<InspectionImage>? listImage) async {
        if (listImage != null || listImage!.isNotEmpty) {
          listImages = listImage;
          setState(InspectionImageViewState.completed);
        } else {
          setState(InspectionImageViewState.incomplete);
        }
      },
    );
  }
}
