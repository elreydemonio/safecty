import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:safecty/feature/inspection_check/inspection_check_view_model.dart';
import 'package:safecty/feature/inspection_check/widget/card_elevation.dart';
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
  List<bool>? isCheckList;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<InspectionCheckViewModel>();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.getParameter();
        if (viewModel.state == InspectionCheckViewState.completed) {
          isCheckList = List.generate(viewModel.listParameters!.length,
              (index) => viewModel.inspection!.parameters);
        }
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
          return ScaffoldWidget(
            selectedIndex: _selectedIndex,
            onTabSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.25,
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.defaultImage),
                      fit: BoxFit.cover,
                    ),
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
                          buildRow('Zona', value.area!.description),
                          const SizedBox(height: 8),
                          buildRow('Riesgo', value.risk!.description),
                          const SizedBox(height: 8),
                          buildRow('Inspection',
                              value.inspection!.descriptionInspection),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.4,
                  padding: const EdgeInsets.only(
                    bottom: Spacing.medium,
                    top: Spacing.medium,
                    left: Spacing.xLarge,
                    right: Spacing.xLarge,
                  ),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Parametros de inspeccion",
                        style: TextStyle(
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
                                check: isCheckList![index],
                                isCheck: (bool? active) {
                                  setState(() {
                                    isCheckList![index] = active!;
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
