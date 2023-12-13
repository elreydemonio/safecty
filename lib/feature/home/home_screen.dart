import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:safecty/core/navigation/named_route.dart';
import 'package:safecty/feature/home/home_view_model.dart';
import 'package:safecty/feature/home/widget/home_card.dart';
import 'package:safecty/generated/l10n.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';
import 'package:safecty/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final viewModel = context.read<HomeViewModel>();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.getDatesUser();
        print(viewModel.user);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<HomeViewModel>(
      builder: (
        context,
        value,
        __,
      ) {
        if (value.state == HomeViewState.loading) {
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == HomeViewState.completed) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child: AppBar(
                backgroundColor: Colors.orange,
              ),
            ),
            body: Column(
              children: [
                InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(NamedRoute.profileScreen),
                  child: Container(
                    color: AppColors.white,
                    height: size.height * 0.11,
                    width: size.width,
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Logo principal
                        Positioned(
                          left: 0.0,
                          child: Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              image: value.user!.profilePicture == null
                                  ? DecorationImage(
                                      image: MemoryImage(
                                        base64.decode(
                                            value.user!.profilePicture!),
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 000,
                          right: size.width * 0.7,
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              image: value.workCenter!.companyLogo.isNotEmpty
                                  ? DecorationImage(
                                      image: MemoryImage(
                                        base64.decode(
                                            value.workCenter!.companyLogo),
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Spacing.xLarge + 60.0),
                          child: Center(
                            child: AutoSizeText(
                              value.workCenter!.businessName,
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
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.medium),
                Container(
                  height: size.height * 0.75,
                  padding: const EdgeInsets.only(
                    bottom: Spacing.small,
                    left: Spacing.xLarge,
                    right: Spacing.large,
                  ),
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            HomeCard(
                              icon: Icons.assignment_outlined,
                              onTap: () => Navigator.of(context).pushNamed(
                                  NamedRoute.homeScreen,
                                  arguments: {"Valor": 1}),
                              title: "Habilidades",
                            ),
                            const SizedBox(width: Spacing.medium),
                            HomeCard(
                              icon: Icons.collections_bookmark,
                              onTap: () => Navigator.of(context)
                                  .pushNamed(NamedRoute.homeScreen),
                              title: "Habilidades",
                            ),
                          ],
                        ),
                        const SizedBox(height: Spacing.medium),
                        Row(
                          children: [
                            HomeCard(
                              icon: Icons.collections_bookmark,
                              onTap: () => Navigator.of(context)
                                  .pushNamed(NamedRoute.homeScreen),
                              title: "Habilidades",
                            ),
                            const SizedBox(width: Spacing.medium),
                            HomeCard(
                              icon: Icons.collections_bookmark,
                              onTap: () => Navigator.of(context)
                                  .pushNamed(NamedRoute.inspectionPlanScreen),
                              title:
                                  AppLocalizations.of(context).inspectionPlan,
                            ),
                          ],
                        ),
                        const SizedBox(height: Spacing.medium),
                        Row(
                          children: [
                            HomeCard(
                              icon: Icons.collections_bookmark,
                              onTap: () => Navigator.of(context)
                                  .pushNamed(NamedRoute.homeScreen),
                              title: "Habilidades",
                            ),
                            const SizedBox(width: Spacing.medium),
                            HomeCard(
                              icon: Icons.collections_bookmark,
                              onTap: () => Navigator.of(context)
                                  .pushNamed(NamedRoute.homeScreen),
                              title: "Habilidades",
                            ),
                          ],
                        )
                      ],
                    ),
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
}
