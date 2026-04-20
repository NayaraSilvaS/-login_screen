import 'package:mobx/mobx.dart';
import '../../core/validators/auth_validator.dart';
import '../../data/services/auth_service.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final AuthService service = AuthService();

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  bool isSuccess = false;


  @computed
  bool get isEmailValid => AuthValidator.isValidEmail(email);

  @computed
  Map<String, bool> get passwordRules =>
      AuthValidator.validatePassword(password);

  @computed
  bool get isFormValid =>
      isEmailValid && !passwordRules.containsValue(false);

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

 @action
Future<void> login() async {
  isLoading = true;
  error = null;
  isSuccess = false;

  try {
    await service.login(email, password);
    isSuccess = true;
  } catch (e) {
    error = e.toString();
  }

  isLoading = false;
}
}
