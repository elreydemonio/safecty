import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:safecty/feature/inspection_check/inspection_check_view_model.dart';
import 'package:safecty/feature/inspection_check/widget/card_elevation.dart';
import 'package:safecty/feature/inspection_image/inspection_image_view_model.dart';
import 'package:safecty/feature/inspection_person/inspection_person_view_model.dart';
import 'package:safecty/generated/l10n.dart';
import 'package:safecty/model/repository/model/parameter_inspecton.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/app_imagen.dart';
import 'package:safecty/theme/spacing.dart';
import 'package:safecty/widgets/loading_widget.dart';
import 'package:safecty/widgets/scafold_widget.dart';
import 'package:safecty/widgets/snackbar.dart';

class InspectionCheckScreen extends StatefulWidget {
  const InspectionCheckScreen({super.key});

  @override
  _InspectionCheckScreenState createState() => _InspectionCheckScreenState();
}

class _InspectionCheckScreenState extends State<InspectionCheckScreen> {
  int _selectedIndex = 0;
  List<ParameterInspection>? listParameters;

  DecorationImage _buildDecorationImage(String? imagePath) {
    if (imagePath != null) {
      return DecorationImage(
        image:
            NetworkImage('http://www.out-safety.com/web/MImagenes/$imagePath'),
        fit: BoxFit.cover,
      );
    } else {
      return const DecorationImage(
        image: AssetImage(AppImages.defaultImage),
        fit: BoxFit.cover,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<InspectionCheckViewModel>();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.getParameter();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<InspectionCheckViewModel>(
      builder: (context, value, child) {
        if (value.state == InspectionCheckViewState.loading) {
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == InspectionCheckViewState.error) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBarWidget(
                message: "Error, volver a cargar la aplicacion",
              ).build(context));
            },
          );
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == InspectionCheckViewState.completed) {
          listParameters = value.listParameters;
          return ScaffoldWidget(
            selectedIndex: _selectedIndex,
            onTabSelected: (index) {
              value.saveParameters(listParameters!);
              value.init();
              final viewModel = context.read<InspectionImageViewModel>();
              viewModel.init();
              final viewModelPerson = context.read<InspectionPersonViewModel>();
              viewModelPerson.init();
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.2,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: _buildDecorationImage(value.inspection?.imagePath),
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  padding: const EdgeInsets.only(
                    bottom: Spacing.medium,
                    top: Spacing.medium,
                    left: Spacing.small,
                    right: Spacing.small,
                  ),
                  width: size.width,
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.all(16),
                      color: AppColors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRow(AppLocalizations.of(context).Zone,
                              value.area!.description),
                          const SizedBox(height: 8),
                          buildRow(AppLocalizations.of(context).risk,
                              value.risk!.description),
                          const SizedBox(height: 8),
                          buildRow(AppLocalizations.of(context).inspection,
                              value.inspection!.descriptionInspection),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.45,
                  padding: const EdgeInsets.only(
                    bottom: Spacing.medium,
                    left: Spacing.xLarge,
                    right: Spacing.xLarge,
                  ),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).inspectionParameters,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: value.listParameters!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: MyContainerWithElevation(
                                index: index,
                                description: value.listParameters![index]
                                    .descriptionParameter,
                                check: value.listParameters![index].isCheck!,
                                isCheck: (bool? active) {
                                  setState(() {
                                    value.listParameters![index].isCheck =
                                        active!;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
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

  Widget buildRow(String title, String description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
