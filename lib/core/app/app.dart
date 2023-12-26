import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:safecty/feature/home/home_view_model.dart';
import 'package:safecty/feature/home_initial.dart';
import 'package:safecty/feature/inspection_check/inspection_check_view_model.dart';
import 'package:safecty/feature/inspection_plan/inspection_plan_view_model.dart';
import 'package:safecty/feature/login/login_view_mode.dart';
import 'package:safecty/feature/profile/profile_view_model.dart';
import 'package:safecty/feature/work_center/work_center_view_model.dart';

import '../../../generated/l10n.dart';
import '../../theme/app_themes.dart';
import '../../theme/theme_view_model.dart';
import '../navigation/app_router.dart';
import 'bootstrapper.dart';

class App extends StatefulWidget {
  const App({
    required this.bootstrapper,
    super.key,
  });

  final Bootstrapper bootstrapper;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<LocalizationsDelegate<dynamic>> _localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    AppLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  @override
  void initState() {
    super.initState();
    widget.bootstrapper.bootstrap();
  }

  @override
  void dispose() {
    super.dispose();
    widget.bootstrapper.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: widget.bootstrapper.bootstrapStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasError) {
          print("Error during bootstrap: ${snapshot.error}");
        }
        Widget result;
        if (snapshot.data ?? true) {
          result = MultiProvider(
            providers: <SingleChildWidget>[
              ChangeNotifierProvider<ThemeViewModel>(
                create: (context) => widget.bootstrapper.themeViewModel,
              ),
              ChangeNotifierProvider<LoginViewModel>(
                create: (context) => widget.bootstrapper.loginViewModel,
              ),
              ChangeNotifierProvider<WorkCenterViewModel>(
                create: (context) => widget.bootstrapper.workCenterViewModel,
              ),
              ChangeNotifierProvider<HomeViewModel>(
                create: (context) => widget.bootstrapper.homeViewModel,
              ),
              ChangeNotifierProvider<ProfileViewModel>(
                create: (context) => widget.bootstrapper.profileViewModel,
              ),
              ChangeNotifierProvider<InspectionPlanViewModel>(
                create: (context) =>
                    widget.bootstrapper.inspectionPlanViewModel,
              ),
              ChangeNotifierProvider<InspectionCheckViewModel>(
                create: (context) =>
                    widget.bootstrapper.inspectionCheckViewModel,
              ),
            ],
            child: Consumer<ThemeViewModel>(
              builder: (_, ThemeViewModel value, __) => MaterialApp(
                theme: AppThemes.lightTheme,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: _localizationsDelegates,
                navigatorKey: widget.bootstrapper.navigatorKey,
                onGenerateRoute: generatedRoutes,
                supportedLocales: AppLocalizations.delegate.supportedLocales,
                title: widget.bootstrapper.flavor.name,
              ),
            ),
          );
        } else {
          result = MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: _localizationsDelegates,
            home: const HomeIntialScreen(),
            supportedLocales: AppLocalizations.delegate.supportedLocales,
          );
        }
        return result;
      },
    );
  }
}
