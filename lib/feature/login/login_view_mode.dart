import 'package:safecty/core/mvvm/base_view_model.dart';
import 'package:safecty/model/repository/login/login_repository_impl.dart';
import 'package:safecty/model/repository/model/user.dart';
import 'package:safecty/model/storage/secure_storage.dart';

enum LoginViewState {
  completed,
  error,
  initial,
  loading,
  data,
}

class LoginViewModel extends BaseViewModel<LoginViewState> {
  LoginViewModel({
    required LoginRepository loginRepository,
    required SecureStorage secureStorage,
  })  : _loginRepository = loginRepository,
        _secureStorage = secureStorage;

  final LoginRepository _loginRepository;
  final SecureStorage _secureStorage;

  void init() => super.initialize(LoginViewState.initial);

  Future<void> login(String user, String password) async {
    setState(LoginViewState.loading);
    final response = await _loginRepository.loginUser(user, password);

    response.fold(
      (failure) => setState(LoginViewState.error),
      (User? user) async {
        if (user == null) {
          setState(LoginViewState.error);
        }
        await _secureStorage.storeUser(user!);
        setState(LoginViewState.completed);
      },
    );
  }

  Future<void> validateGetUser() async {
    setState(LoginViewState.loading);
    try {
      User? user = await _secureStorage.getUser();
      if (user == null) {
        setState(LoginViewState.initial);
      } else {
        setState(LoginViewState.data);
      }
    } catch (e) {
      setState(LoginViewState.error);
    }
  }
}
