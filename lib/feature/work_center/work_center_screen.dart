import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:safecty/core/navigation/named_route.dart';
import 'package:safecty/feature/work_center/work_center_view_model.dart';
import 'package:safecty/generated/l10n.dart';
import 'package:safecty/model/repository/model/work_center.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';
import 'package:safecty/widgets/loading_widget.dart';

class WorkCenterScreen extends StatefulWidget {
  const WorkCenterScreen({
    super.key,
    required this.identificationCard,
  });

  final String identificationCard;

  @override
  State<WorkCenterScreen> createState() => _WorkCenterScreenState();
}

class _WorkCenterScreenState extends State<WorkCenterScreen> {
  final TextEditingController _filter = TextEditingController();
  List<bool>? isCardExpandedList;
  List<WorkCenter>? workCenterListFilter;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<WorkCenterViewModel>();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.getWorkCenter(widget.identificationCard);
        if (viewModel.state == WorkCenterViewState.completed) {
          workCenterListFilter = viewModel.workCenterList!;
          isCardExpandedList =
              List.generate(workCenterListFilter!.length, (index) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<WorkCenterViewModel>(
      builder: (
        context,
        value,
        __,
      ) {
        if (value.state == WorkCenterViewState.loading) {
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == WorkCenterViewState.completedStore) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              value.init();
              Navigator.of(context).pushReplacementNamed(NamedRoute.homeScreen);
            },
          );
        }
        if (value.state == WorkCenterViewState.error) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child: AppBar(
                backgroundColor: Colors.orange,
              ),
            ),
            body: Container(
              height: size.height,
              margin: const EdgeInsets.only(
                top: Spacing.large,
                right: Spacing.medium,
                left: Spacing.medium,
                bottom: Spacing.xSmall,
              ),
              width: size.width,
              child: const Column(
                children: [
                  Center(
                    child: Text("Ha ocurrido un error"),
                  )
                ],
              ),
            ),
          );
        }
        if (value.state == WorkCenterViewState.completed) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child: AppBar(
                backgroundColor: Colors.orange,
              ),
            ),
            body: Container(
              height: size.height,
              margin: const EdgeInsets.only(
                top: Spacing.large,
                right: Spacing.medium,
                left: Spacing.medium,
                bottom: Spacing.xSmall,
              ),
              width: size.width,
              child: Column(
                children: [
                  TextFormField(
                    controller: _filter,
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                      icon: const Icon(Icons.search),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _filter.text.isNotEmpty
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (text) {
                      setState(
                        () {
                          if (text.isEmpty) {
                            workCenterListFilter = value.workCenterList;
                          } else {
                            workCenterListFilter = value.workCenterList!
                                .where(
                                  (workCenter) => workCenter.businessName
                                      .toLowerCase()
                                      .contains(
                                        text.toLowerCase(),
                                      ),
                                )
                                .toList();
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: Spacing.medium),
                  Expanded(
                    child: ListView.builder(
                      itemCount: workCenterListFilter!.length,
                      itemBuilder: (context, index) {
                        double cardHeight = isCardExpandedList![index]
                            ? size.height * 0.4
                            : size.height * 0.12;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isCardExpandedList![index] =
                                  !isCardExpandedList![index];
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            height: cardHeight,
                            padding: const EdgeInsets.only(top: Spacing.medium),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: AppColors.transparent,
                                        backgroundImage: MemoryImage(
                                          base64Decode(
                                            workCenterListFilter![index]
                                                .companyLogo,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          workCenterListFilter![index]
                                              .businessName,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 10,
                                          stepGranularity: 10,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(isCardExpandedList![index]
                                          ? Icons.arrow_drop_up
                                          : Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                                if (isCardExpandedList![index])
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    color: Colors.grey,
                                    height: size.height * 0.25,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            workCenterListFilter![index]
                                                .informativeMessage,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                              height: Spacing.medium),
                                          ElevatedButton(
                                            onPressed: () =>
                                                value.savedWorkCenterId(
                                              workCenterListFilter![index],
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .select,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
}
