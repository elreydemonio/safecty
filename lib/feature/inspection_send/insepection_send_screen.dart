import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:safecty/core/navigation/named_route.dart';
import 'package:safecty/feature/home/home_view_model.dart';
import 'package:safecty/feature/inspection_check/inspection_check_view_model.dart';
import 'package:safecty/feature/inspection_image/inspection_image_view_model.dart';
import 'package:safecty/feature/inspection_person/inspection_person_view_model.dart';
import 'package:safecty/feature/inspection_send/inspection_send_view_model.dart';
import 'package:safecty/theme/app_animation.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';

class InspectionSendScreen extends StatefulWidget {
  const InspectionSendScreen({super.key});

  @override
  State<InspectionSendScreen> createState() => _InspectionSendScreenState();
}

class _InspectionSendScreenState extends State<InspectionSendScreen> {
  @override
  void initState() {
    super.initState();
    final viewModel = context.read<InspectionSendViewModel>();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.sendInspection();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<InspectionSendViewModel>(
      builder: (context, value, child) {
        if (value.state == InspectionSendViewState.error) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              showDialogSend(
                title: 'Error',
                description: 'Ocurrió un error al enviar la inspección.',
                onPressed: () {
                  final viewModel = context.read<InspectionPersonViewModel>();
                  viewModel.init();
                  Navigator.of(context)
                      .pushReplacementNamed(NamedRoute.inspectionPersonScreen);
                },
              );
            },
          );
        }
        if (value.state == InspectionSendViewState.incompletePerson) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              showDialogSend(
                title: 'Incompleto',
                description: 'No hay personas selecionadas.',
                onPressed: () {
                  final viewModel = context.read<InspectionPersonViewModel>();
                  viewModel.init();
                  Navigator.of(context)
                      .pushReplacementNamed(NamedRoute.inspectionPersonScreen);
                },
              );
            },
          );
        }
        if (value.state == InspectionSendViewState.incompleteCheck) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              showDialogSend(
                title: 'Incompleto',
                description: 'No hay informacion sobre los parametros ',
                onPressed: () {
                  final viewModel = context.read<InspectionCheckViewModel>();
                  viewModel.init();
                  Navigator.of(context)
                      .pushReplacementNamed(NamedRoute.inspectionCheckScreen);
                },
              );
            },
          );
        }
        if (value.state == InspectionSendViewState.incompleteImage) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              showDialogSend(
                title: 'Incompleto',
                description: 'No hay informacion sobre las imagenes',
                onPressed: () {
                  final viewModel = context.read<InspectionImageViewModel>();
                  viewModel.init();
                  Navigator.of(context)
                      .pushReplacementNamed(NamedRoute.inspectionImageScreen);
                },
              );
            },
          );
        }
        if (value.state == InspectionSendViewState.completed) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              showDialogSend(
                title: 'Éxito',
                description: 'La inspección se envió exitosamente.',
                onPressed: () {
                  final viewModel = context.read<HomeViewModel>();
                  viewModel.init();
                  Navigator.of(context)
                      .pushReplacementNamed(NamedRoute.homeScreen);
                },
              );
            },
          );
        }
        if (value.state == InspectionSendViewState.incomplete) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              showDialogSend(
                title: 'Incompleto',
                description: 'Falta informacion en la inspeccion.',
                onPressed: () {
                  final viewModel = context.read<InspectionPersonViewModel>();
                  viewModel.init();
                  Navigator.of(context)
                      .pushReplacementNamed(NamedRoute.inspectionPersonScreen);
                },
              );
            },
          );
        }
        return body(size);
      },
    );
  }

  Widget body(Size size) {
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppAnimation.loadingInspectionAnimation),
            const SizedBox(height: Spacing.medium),
            const Text(
              "Por favor esperen que se termine de enviar la informacion",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> showDialogSend({
    required String title,
    required String description,
    required VoidCallback onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
