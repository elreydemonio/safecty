import 'package:safecty/core/mvvm/base_view_model.dart';
import 'package:safecty/model/repository/model/user.dart';
import 'package:safecty/model/repository/model/work_center.dart';
import 'package:safecty/model/storage/secure_storage.dart';

enum HomeViewState {
  completed,
  error,
  initial,
  loading,
}

class HomeViewModel extends BaseViewModel<HomeViewState> {
  HomeViewModel({
    required SecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;

  WorkCenter? _workCenter;
  User? _user;

  WorkCenter? get workCenter => _workCenter;
  User? get user => _user;

  void init() => super.initialize(HomeViewState.initial);

  Future<void> getDatesUser() async {
    setState(HomeViewState.loading);
    try {
      _user = await _secureStorage.getUser();
      _workCenter = await _secureStorage.getWorkCenter();
      setState(HomeViewState.completed);
    } catch (e) {
      setState(HomeViewState.error);
    }
  }
}
