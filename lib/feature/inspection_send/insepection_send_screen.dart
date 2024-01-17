import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:safecty/core/navigation/named_route.dart';
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
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content:
                      const Text('Ocurrió un error al enviar la inspección.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          });
        }
        if (value.state == InspectionSendViewState.completed) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Éxito'),
                  content: const Text('La inspección se envió exitosamente.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(NamedRoute.homeScreen),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          });
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
}