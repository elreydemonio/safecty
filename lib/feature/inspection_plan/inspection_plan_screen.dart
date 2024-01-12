import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:safecty/core/navigation/named_route.dart';
import 'package:safecty/feature/inspection_plan/inspection_plan_view_model.dart';
import 'package:safecty/feature/inspection_plan/widget/aler_dialog_plan.dart';
import 'package:safecty/feature/inspection_plan/widget/button_text.dart';
import 'package:safecty/feature/inspection_plan/widget/button_tooltip.dart';
import 'package:safecty/feature/inspection_plan/widget/card_inspection_plan.dart';
import 'package:safecty/generated/l10n.dart';
import 'package:safecty/model/repository/model/dropdown_type.dart';
import 'package:safecty/model/repository/model/gdp_data.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';
import 'package:safecty/widgets/loading_widget.dart';
import 'package:safecty/widgets/snackbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InspectionPlanScreen extends StatefulWidget {
  const InspectionPlanScreen({super.key});

  @override
  State<InspectionPlanScreen> createState() => _InspectionPlanScreenState();
}

class _InspectionPlanScreenState extends State<InspectionPlanScreen>
    with SingleTickerProviderStateMixin {
  final List<GDPDATA> _chartData = [];
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  double convert(double valor, double maximum) {
    double percentage = (valor / maximum).clamp(0, 1);
    double percentageConvert = 1 - percentage;
    return percentageConvert;
  }

  List<DropDownType> dropDownType = [
    DropDownType('1', 'Zone 1'),
    DropDownType('2', 'Zone 3'),
  ];

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<InspectionPlanViewModel>();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.getInspections();
        await viewModel.getArea();
        await viewModel.getRisk();
        if (viewModel.state == InspectionPlanViewState.completed) {
          _chartData.add(
            GDPDATA(
              "Ejecutando",
              viewModel.inspectionsPlanPending!.charInspection == null
                  ? 0
                  : viewModel.inspectionsPlanPending!.charInspection!.executed
                      .toInt(),
            ),
          );
          _chartData.add(
            GDPDATA(
              "Planeado",
              viewModel.inspectionsPlanPending!.charInspection == null
                  ? 0
                  : viewModel.inspectionsPlanPending!.charInspection!.scheduled
                      .toInt(),
            ),
          );
          _chartData.add(
            GDPDATA(
              "Pediente",
              viewModel.inspectionsPlanPending!.charInspection == null
                  ? 0
                  : viewModel.inspectionsPlanPending!.charInspection!.pending
                      .toInt(),
            ),
          );
          _chartData.add(
            GDPDATA(
              "Avance",
              viewModel.inspectionsPlanPending!.charInspection == null
                  ? 0
                  : viewModel.inspectionsPlanPending!.charInspection!.fulfill
                      .toInt(),
            ),
          );
        }
      },
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<InspectionPlanViewModel>(
      builder: (
        context,
        value,
        __,
      ) {
        if (value.state == InspectionPlanViewState.loading) {
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == InspectionPlanViewState.error) {
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
        if (value.state == InspectionPlanViewState.completedStore) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              value.init();
              Navigator.of(context)
                  .pushReplacementNamed(NamedRoute.inspectionCheckScreen);
            },
          );
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == InspectionPlanViewState.completed ||
            value.state == InspectionPlanViewState.completedInspection ||
            value.state == InspectionPlanViewState.loadingInspection) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child: AppBar(
                backgroundColor: Colors.orange.shade900,
              ),
            ),
            body: Column(
              children: [
                Container(
                  color: Colors.orange,
                  height: size.height * 0.1,
                  padding: const EdgeInsets.only(
                    left: Spacing.medium,
                    top: Spacing.medium,
                    right: Spacing.medium,
                  ),
                  width: size.width,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.black,
                        size: 30.0,
                      ),
                      SizedBox(width: Spacing.medium),
                      Text(
                        "Ousafety app",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.4,
                  padding: const EdgeInsets.only(
                    top: Spacing.xLarge,
                    bottom: Spacing.xLarge,
                  ),
                  width: size.width,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(right: Spacing.xLarge + 45.0),
                        child: SfCircularChart(
                          legend: const Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            position: LegendPosition.top,
                          ),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                          ),
                          series: <CircularSeries>[
                            RadialBarSeries<GDPDATA, String>(
                              dataSource: _chartData,
                              xValueMapper: (GDPDATA data, _) => data.content,
                              yValueMapper: (GDPDATA data, _) => data.gdp,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                              ),
                              enableTooltip: true,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: Spacing.medium,
                        child: Tooltip(
                          message: _isExpanded ? 'Cerrar' : 'Expandir',
                          child: FloatingActionButton(
                            backgroundColor: Colors.orange,
                            onPressed: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                                if (_isExpanded) {
                                  _animationController.forward();
                                } else {
                                  _animationController.reverse();
                                }
                              });
                            },
                            child: _isExpanded
                                ? const Icon(Icons.close)
                                : const Icon(Icons.add),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: Spacing.xLarge + 28.0,
                        right: Spacing.medium,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ExpandedButtonText(
                                    text: AppLocalizations.of(context)
                                        .certificate,
                                  ),
                                  ExpandedButtonWithTooltip(
                                    icon: Icons.star,
                                    tooltipText: '',
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ExpandedButtonText(
                                    text:
                                        AppLocalizations.of(context).readingQr,
                                  ),
                                  ExpandedButtonWithTooltip(
                                    icon: Icons.qr_code,
                                    tooltipText: '',
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ExpandedButtonText(
                                    text: AppLocalizations.of(context)
                                        .newInspection,
                                  ),
                                  ExpandedButtonWithTooltip(
                                    icon: Icons.person_add_alt,
                                    tooltipText: '',
                                    onTap: () {
                                      _showModal(
                                        context: context,
                                        size: size,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.4,
                  padding: const EdgeInsets.all(Spacing.medium),
                  width: size.width,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount:
                          value.inspectionsPlanPending!.listInspection.length,
                      itemBuilder: (context, index) {
                        return CardInspectionPlan(
                          onTap: () {
                            value.setConfig(
                              value.inspectionsPlanPending!
                                  .listInspection[index].riskId
                                  .toString(),
                              value.inspectionsPlanPending!
                                  .listInspection[index].inspectionId
                                  .toString(),
                            );
                            value.getInspectionList(value
                                .inspectionsPlanPending!
                                .listInspection[index]
                                .riskId);
                            _showModal(
                              context: context,
                              size: size,
                              riskId: value.inspectionsPlanPending!
                                  .listInspection[index].riskId
                                  .toString(),
                            );
                          },
                          height: size.height * 0.18,
                          width: size.width,
                          executed: value.inspectionsPlanPending!
                              .listInspection[index].executed
                              .toInt()
                              .toString(),
                          total:
                              '${value.inspectionsPlanPending!.listInspection[index].pending.toInt()}/${value.inspectionsPlanPending!.listInspection[index].scheduled.toInt()}',
                          scheduled: value.inspectionsPlanPending!
                              .listInspection[index].scheduled,
                          name: value.inspectionsPlanPending!
                              .listInspection[index].inspectionName,
                        );
                      },
                    ),
                  ),
                ),
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

  void _showModal({
    required BuildContext context,
    required Size size,
    String? riskId,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogPlan(
          size: size,
          riskId: riskId,
        );
      },
    ).then((value) {
      final viewModel = context.read<InspectionPlanViewModel>();
      viewModel.setConfig(null, null);
    });
  }
}
