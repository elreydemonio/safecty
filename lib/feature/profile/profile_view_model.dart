import 'package:safecty/core/mvvm/base_view_model.dart';
import 'package:safecty/model/repository/model/user.dart';
import 'package:safecty/model/repository/model/work_center.dart';
import 'package:safecty/model/storage/secure_storage.dart';

enum ProfileViewState {
  completed,
  logout,
  error,
  initial,
  loading,
}

class ProfileViewModel extends BaseViewModel<ProfileViewState> {
  ProfileViewModel({
    required SecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;

  WorkCenter? _workCenter;
  User? _user;

  WorkCenter? get workCenter => _workCenter;
  User? get user => _user;

  void init() => super.initialize(ProfileViewState.initial);

  Future<void> getDatesUser() async {
    setState(ProfileViewState.loading);
    try {
      _user = await _secureStorage.getUser();
      _workCenter = await _secureStorage.getWorkCenter();
      setState(ProfileViewState.completed);
    } catch (e) {
      setState(ProfileViewState.error);
    }
  }

  Future<void> logout() async {
    setState(ProfileViewState.loading);
    try {
      await _secureStorage.logout();
      setState(ProfileViewState.logout);
    } catch (e) {
      setState(ProfileViewState.error);
    }
  }
}
