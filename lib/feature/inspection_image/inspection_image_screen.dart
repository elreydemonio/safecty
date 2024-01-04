import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:safecty/feature/inspection_image/inspection_image_view_model.dart';
import 'package:safecty/feature/inspection_image/widget/inspection_image_dialog.dart';
import 'package:safecty/feature/inspection_image/widget/inspection_image_item.dart';
import 'package:safecty/feature/inspection_person/inspection_person_view_model.dart';
import 'package:safecty/model/repository/model/inspection_image.dart';
import 'package:safecty/widgets/loading_widget.dart';

import 'package:safecty/widgets/scafold_widget.dart';
import 'package:safecty/widgets/snackbar.dart';

class InspectionImageScreen extends StatefulWidget {
  const InspectionImageScreen({super.key});

  @override
  State<InspectionImageScreen> createState() => _InspectionImageScreenState();
}

class _InspectionImageScreenState extends State<InspectionImageScreen> {
  int _selectedIndex = 1;
  List<InspectionImage>? listInspectionImage;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<InspectionImageViewModel>();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.getImages();
        if (viewModel.state == InspectionImageViewState.completed) {
          listInspectionImage = viewModel.listImages;
        }

        if (viewModel.state == InspectionImageViewState.incomplete) {
          listInspectionImage = [];
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<InspectionImageViewModel>(
      builder: (context, value, child) {
        if (value.state == InspectionImageViewState.loading) {
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == InspectionImageViewState.error) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBarWidget(
                message: "Error, volver a cargar la aplicación",
              ).build(context));
            },
          );
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == InspectionImageViewState.completed) {
          return ScaffoldWidget(
            selectedIndex: _selectedIndex,
            onTabSelected: (index) {
              setState(() {
                value.saveImages(listInspectionImage!);
                final viewModelPerson =
                    context.read<InspectionPersonViewModel>();
                viewModelPerson.init();
                _selectedIndex = index;
              });
            },
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () => _showModal(
                context: context,
                size: size,
              ),
              child: const Icon(Icons.camera_alt_rounded),
            ),
            child: Expanded(
              child: ListView.builder(
                itemCount: listInspectionImage!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InspectionImageItem(
                      onEdit: () => _showModal(
                        context: context,
                        size: size,
                        image: listInspectionImage![index],
                      ),
                      inspectionImage: listInspectionImage![index],
                      onDelete: () => setState(
                        () {
                          listInspectionImage!.removeAt(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return LoadingWidget(
          height: size.height,
          width: size.width,
        );
      },
    );
  }

  void _showModal(
      {required context, required Size size, InspectionImage? image}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InspectionImageDialog(
          inspectionImage: image,
          onImageAdded: (editedImage) {
            if (image != null) {
              int index = listInspectionImage!.indexOf(image);
              listInspectionImage![index] = editedImage;
            } else {
              listInspectionImage!.add(editedImage);
            }
            context
                .read<InspectionImageViewModel>()
                .saveImages(listInspectionImage!);
          },
        );
      },
    );
  }
}
