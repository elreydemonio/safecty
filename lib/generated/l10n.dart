// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Plan de inspecciones `
  String get inspectionPlan {
    return Intl.message(
      'Plan de inspecciones ',
      name: 'inspectionPlan',
      desc: '',
      args: [],
    );
  }

  /// `hola`
  String get hello {
    return Intl.message(
      'hola',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Informacion de la cuenta`
  String get infoProfile {
    return Intl.message(
      'Informacion de la cuenta',
      name: 'infoProfile',
      desc: '',
      args: [],
    );
  }

  /// `Centro de trabajo`
  String get workCenters {
    return Intl.message(
      'Centro de trabajo',
      name: 'workCenters',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar centro de trabajo`
  String get ChangeWorkCenter {
    return Intl.message(
      'Cambiar centro de trabajo',
      name: 'ChangeWorkCenter',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar sesión`
  String get signOff {
    return Intl.message(
      'Cerrar sesión',
      name: 'signOff',
      desc: '',
      args: [],
    );
  }

  /// `Se elimina todo los datos locales`
  String get deleteLocalDate {
    return Intl.message(
      'Se elimina todo los datos locales',
      name: 'deleteLocalDate',
      desc: '',
      args: [],
    );
  }

  /// `Enviar`
  String get send {
    return Intl.message(
      'Enviar',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Inspection`
  String get inspection {
    return Intl.message(
      'Inspection',
      name: 'inspection',
      desc: '',
      args: [],
    );
  }

  /// `Elegir inspection`
  String get selectInspection {
    return Intl.message(
      'Elegir inspection',
      name: 'selectInspection',
      desc: '',
      args: [],
    );
  }

  /// `Riesgo`
  String get risk {
    return Intl.message(
      'Riesgo',
      name: 'risk',
      desc: '',
      args: [],
    );
  }

  /// `Elegir riesgo`
  String get selectRisk {
    return Intl.message(
      'Elegir riesgo',
      name: 'selectRisk',
      desc: '',
      args: [],
    );
  }

  /// `Zona`
  String get Zone {
    return Intl.message(
      'Zona',
      name: 'Zone',
      desc: '',
      args: [],
    );
  }

  /// `Elegir zona`
  String get selectZone {
    return Intl.message(
      'Elegir zona',
      name: 'selectZone',
      desc: '',
      args: [],
    );
  }

  /// `Configurar inspección`
  String get configureInspection {
    return Intl.message(
      'Configurar inspección',
      name: 'configureInspection',
      desc: '',
      args: [],
    );
  }

  /// `nueva inspección`
  String get newInspection {
    return Intl.message(
      'nueva inspección',
      name: 'newInspection',
      desc: '',
      args: [],
    );
  }

  /// `Leer qr`
  String get readingQr {
    return Intl.message(
      'Leer qr',
      name: 'readingQr',
      desc: '',
      args: [],
    );
  }

  /// `certificado`
  String get certificate {
    return Intl.message(
      'certificado',
      name: 'certificate',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es', countryCode: 'CO'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
