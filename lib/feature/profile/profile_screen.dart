import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:safecty/core/navigation/named_route.dart';
import 'package:safecty/feature/profile/profile_view_model.dart';
import 'package:safecty/feature/profile/widget/profile_card.dart';
import 'package:safecty/generated/l10n.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';
import 'package:safecty/widgets/loading_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final viewModel = context.read<ProfileViewModel>();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.getDatesUser();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ProfileViewModel>(
      builder: (
        context,
        value,
        __,
      ) {
        if (value.state == ProfileViewState.loading) {
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == ProfileViewState.logout) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.of(context)
                  .pushReplacementNamed(NamedRoute.loginScreen);
            },
          );
        }
        if (value.state == ProfileViewState.completed) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child: AppBar(
                backgroundColor: Colors.orange,
              ),
            ),
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Container(
                    color: Colors.orange.shade100,
                    height: size.height * 0.35,
                    padding: const EdgeInsets.only(top: Spacing.medium),
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60.0,
                          backgroundColor: AppColors.gray,
                          backgroundImage: MemoryImage(
                            base64Decode(value.user!.profilePicture == null
                                ? ""
                                : value.user!.profilePicture!),
                          ),
                        ),
                        const SizedBox(height: Spacing.small),
                        Text(
                          value.user!.fullName,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: Spacing.small),
                        Text(
                          value.user!.identificationCard,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: Spacing.small),
                        SizedBox(
                          width: size.width * 0.5,
                          child: Text(
                            value.workCenter!.businessName,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.55,
                    padding: const EdgeInsets.only(
                      bottom: Spacing.small,
                      left: Spacing.medium,
                      right: Spacing.medium,
                      top: Spacing.xLarge,
                    ),
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).infoProfile,
                          style: const TextStyle(
                            color: AppColors.gray,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: Spacing.medium),
                        ProfileCard(
                          icon: Icons.business,
                          onTap: () =>
                              Navigator.of(context).pushReplacementNamed(
                            NamedRoute.workCenterScreen,
                            arguments: {
                              "identificationCard":
                                  value.user!.identificationCard,
                            },
                          ),
                          title: AppLocalizations.of(context).workCenters,
                          subTitle:
                              AppLocalizations.of(context).ChangeWorkCenter,
                        ),
                        const SizedBox(height: Spacing.medium),
                        ProfileCard(
                          icon: Icons.business,
                          onTap: () async => await value.logout(),
                          title: AppLocalizations.of(context).signOff,
                          subTitle:
                              AppLocalizations.of(context).deleteLocalDate,
                        ),
                      ],
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
