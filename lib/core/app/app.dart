import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:safecty/feature/home/home_screen.dart';

import '../../../generated/l10n.dart';
import '../../theme/app_themes.dart';
import '../../theme/theme_view_model.dart';
import '../navigation/app_router.dart';
import 'bootstrapper.dart';

class App extends StatefulWidget {
  const App({
    required this.bootstrapper,
    Key? key,
  }) : super(key: key);

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
        Widget result;
        if (snapshot.data ?? true) {
          result = MultiProvider(
            providers: <SingleChildWidget>[
              ChangeNotifierProvider<ThemeViewModel>(
                create: (context) => widget.bootstrapper.themeViewModel,
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
            home: const HomeScreen(title: "Default"),
            supportedLocales: AppLocalizations.delegate.supportedLocales,
          );
        }
        return result;
      },
    );
  }
}
