import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safecty/feature/inspection_plan/inspection_plan_view_model.dart';
import 'package:safecty/generated/l10n.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';
import 'package:safecty/widgets/color_button.dart';
import 'package:safecty/widgets/drop_dow_inspection.dart';

class AlertDialogPlan extends StatefulWidget {
  const AlertDialogPlan({
    super.key,
    required this.size,
    this.riskId,
    this.inspectionId,
  });

  final Size size;
  final String? riskId;
  final String? inspectionId;

  @override
  State<AlertDialogPlan> createState() => _AlertDialogPlanState();
}

class _AlertDialogPlanState extends State<AlertDialogPlan> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<InspectionPlanViewModel>(
      builder: (context, value, child) {
        return AlertDialog(
          backgroundColor: AppColors.whiteBone,
          content: SizedBox(
            width: widget.size.width * 0.6,
            height: widget.inspectionId == null
                ? widget.size.height * 0.55
                : widget.size.height * 0.3,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context).configureInspection,
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Spacing.medium),
                    DropDowInspection(
                      label: AppLocalizations.of(context).Zone,
                      hinText: AppLocalizations.of(context).selectZone,
                      data: value.areaList!,
                      value: value.valueZone,
                      onChange: (newValue) {
                        setState(() {
                          value.valueZone = newValue;
                        });
                      },
                    ),
                    widget.riskId == null
                        ? const SizedBox(height: Spacing.medium)
                        : const SizedBox(),
                    widget.riskId == null
                        ? DropDowInspection(
                            label: AppLocalizations.of(context).risk,
                            hinText: AppLocalizations.of(context).selectRisk,
                            data: value.riskList!,
                            value: value.risk,
                            onChange: (risk) async {
                              setState(() {
                                value.risk = risk;
                              });

                              if (risk != null) {
                                await value.getInspectionList(int.parse(risk));
                              }
                            },
                          )
                        : const SizedBox(),
                    widget.inspectionId == null
                        ? const SizedBox(height: Spacing.medium)
                        : const SizedBox(),
                    value.inspectionList == null
                        ? const SizedBox()
                        : widget.inspectionId == null
                            ? DropDowInspection(
                                label: AppLocalizations.of(context).inspection,
                                hinText: AppLocalizations.of(context)
                                    .selectInspection,
                                data: value.inspectionList!,
                                value: value.inspectionValue,
                                onChange: (newValue) {
                                  setState(() {
                                    value.inspectionValue = newValue;
                                  });
                                },
                              )
                            : const SizedBox(),
                    const SizedBox(height: Spacing.xLarge),
                    MyElevatedButton(
                      width: widget.size.width * 0.5,
                      height: 50.0,
                      onPressed: () async {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                          value.inspectionValue;
                          await value.savedConfig();
                        }
                      },
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.orange[200]!, Colors.orange[800]!],
                      ),
                      isLoading: value.state ==
                          InspectionPlanViewState.loadingInspection,
                      child: Text(
                        AppLocalizations.of(context).send,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
