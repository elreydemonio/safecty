import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:safecty/core/app/flavor.dart';
import 'package:safecty/feature/home/home_view_model.dart';
import 'package:safecty/feature/login/login_view_mode.dart';
import 'package:safecty/feature/profile/profile_view_model.dart';
import 'package:safecty/feature/work_center/work_center_view_model.dart';
import 'package:safecty/model/repository/login/login_repository.dart';
import 'package:safecty/model/repository/work_center/work_center_impl.dart';

import '../../model/config.dart';
import '../../model/repository/client/network_client.dart';
import '../../model/repository/client/network_logger.dart';
import '../../model/storage/secure_storage.dart';
import '../../model/storage/secure_storage_impl.dart';
import '../../theme/theme_view_model.dart';

abstract class Bootstrapper {
  factory Bootstrapper.fromFlavor(Flavor flavor) {
    Bootstrapper result;
    switch (flavor) {
      case Flavor.develop:
        result = _DevelopBootstrapper();
        break;

      case Flavor.master:
        result = _MasterBootstrapper();
        break;
    }
    return result;
  }

  PackageInfo get appVersion;

  Stream<bool> get bootstrapStream;

  HomeViewModel get homeViewModel;

  LoginViewModel get loginViewModel;

  ProfileViewModel get profileViewModel;

  WorkCenterViewModel get workCenterViewModel;

  Config get config;

  Flavor get flavor;

  ThemeViewModel get themeViewModel;

  GlobalKey<NavigatorState> get navigatorKey;

  Future<void> bootstrap();

  void dispose();

  bool isInitialized();
}

class _BaseBootstrapper implements Bootstrapper {
  _BaseBootstrapper(Flavor flavor) : _flavor = flavor;

  final StreamController<bool> _bootstrapStreamController =
      StreamController<bool>.broadcast();
  final Flavor _flavor;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  late PackageInfo _appversion;
  late Config _config;
  late Connectivity _connectivity;
  late NetworkClient _networkClient;
  late ThemeViewModel _themeViewModel;
  late NetworkLogger _networkLogger;
  late SecureStorage _secureStorage;
  late HomeViewModel _homeViewModel;
  late LoginViewModel _loginViewModel;
  late WorkCenterViewModel _centerViewModel;
  late ProfileViewModel _profileViewModel;

  bool _initialized = false;

  @override
  Future<void> bootstrap() async {
    if (!_initialized) {
      _appversion = await PackageInfo.fromPlatform();

      final String configJson = await rootBundle.loadString(_flavor.configFile);

      _config = Config.fromMap(json.decode(configJson) as Map<String, dynamic>);

      _networkLogger = NetworkLogger();

      _secureStorage = SecureStorageImpl();

      _connectivity = Connectivity();
      final status = await _connectivity.checkConnectivity();

      _networkClient = NetworkClient(
        connectivityStream: _connectivity.onConnectivityChanged,
        networkLogger: _networkLogger,
        secureStorage: _secureStorage,
      );

      await _networkClient.initialize(
        isOnline: status != ConnectivityResult.none,
      );

      _homeViewModel = HomeViewModel(secureStorage: _secureStorage);

      _loginViewModel = LoginViewModel(
        loginRepository: LoginRepositoryImpl(
          endpoints: _config.endpoints,
          networkClient: _networkClient,
        ),
        secureStorage: _secureStorage,
      );

      _profileViewModel = ProfileViewModel(secureStorage: _secureStorage);

      _centerViewModel = WorkCenterViewModel(
        workCenterRepository: WorkCenterRepositoryImpl(
          endpoints: _config.endpoints,
          networkClient: _networkClient,
        ),
        secureStorage: _secureStorage,
      );

      _themeViewModel = ThemeViewModel(
        secureStorage: _secureStorage,
      );

      _initialized = true;

      _bootstrapStreamController.add(_initialized);
    }
  }

  @override
  PackageInfo get appVersion => _appversion;

  @override
  Stream<bool> get bootstrapStream => _bootstrapStreamController.stream;

  @override
  Config get config => _config;

  @override
  Flavor get flavor => _flavor;

  @override
  HomeViewModel get homeViewModel => _homeViewModel;

  @override
  ProfileViewModel get profileViewModel => _profileViewModel;

  @override
  LoginViewModel get loginViewModel => _loginViewModel;

  @override
  WorkCenterViewModel get workCenterViewModel => _centerViewModel;

  @override
  ThemeViewModel get themeViewModel => _themeViewModel;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  void dispose() {
    _initialized = false;
    _bootstrapStreamController.add(_initialized);
    _bootstrapStreamController.close();
  }

  @override
  bool isInitialized() => _initialized;
}

class _DevelopBootstrapper extends _BaseBootstrapper {
  _DevelopBootstrapper() : super(Flavor.develop);
}

class _MasterBootstrapper extends _BaseBootstrapper {
  _MasterBootstrapper() : super(Flavor.master);
}
