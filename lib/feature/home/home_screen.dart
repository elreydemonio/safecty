import 'package:flutter/material.dart';
import 'package:safecty/core/navigation/named_route.dart';
import 'package:safecty/feature/home/widgets/home_cards.dart';
import 'package:safecty/generated/l10n.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(
            color: AppColors.black,
            height: size.height * 0.15,
            width: size.width,
            child: const Row(),
          ),
          const SizedBox(height: Spacing.medium),
          Container(
            height: size.height * 0.8,
            margin: const EdgeInsets.only(
              bottom: Spacing.small,
              left: Spacing.medium,
              right: Spacing.medium,
            ),
            width: size.width,
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
                      title: AppLocalizations.of(context).inspectionPlan,
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
          )
        ],
      ),
    );
  }
}
