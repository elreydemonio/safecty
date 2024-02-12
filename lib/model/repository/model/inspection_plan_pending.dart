import 'package:safecty/model/repository/model/chart_inspction_plan.dart';
import 'package:safecty/model/repository/model/inspection_plan_table.dart';

class InspectionsPlanPending {
  InspectionsPlanPending({
    required this.listInspection,
    required this.charInspection,
  });

  List<InspectionPlanTable> listInspection;
  CharInspectionPlan? charInspection;
}
