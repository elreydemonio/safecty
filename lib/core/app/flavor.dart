enum Flavor {
  develop,
  master,
}

extension FlavorExtension on Flavor {
  static const developConfigFile = 'assets/config/develop_config.json';
  static const masterConfigFile = 'assets/config/master_config.json';

  String get configFile {
    switch (this) {
      case Flavor.develop:
        return developConfigFile;
      case Flavor.master:
        return masterConfigFile;
    }
  }
}
