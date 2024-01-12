import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:safecty/core/navigation/named_route.dart';
import 'package:safecty/feature/login/login_view_mode.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/app_imagen.dart';
import 'package:safecty/theme/spacing.dart';
import 'package:safecty/widgets/color_button.dart';
import 'package:safecty/widgets/snackbar.dart';
import 'package:safecty/widgets/loading_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    this.logout,
  });

  final String? logout;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<LoginViewModel>();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.validateGetUser(widget.logout);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<LoginViewModel>(
      builder: (
        context,
        value,
        __,
      ) {
        if (value.state == LoginViewState.loading) {
          return LoadingWidget(
            height: size.height,
            width: size.width,
          );
        }
        if (value.state == LoginViewState.error) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBarWidget(message: "Error").build(context));
              value.init();
            },
          );
        }
        if (value.state == LoginViewState.completed) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              value.init();
              Navigator.of(context).pushReplacementNamed(
                NamedRoute.workCenterScreen,
                arguments: {"identificationCard": _userController.text},
              );
            },
          );
        }
        if (value.state == LoginViewState.data) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.of(context).pushReplacementNamed(NamedRoute.homeScreen);
              value.init();
            },
          );
        }
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                    ),
                  ),
                  height: size.height * 0.4,
                  width: size.width,
                  child: Center(
                    child: Image.asset(
                      AppImages.logo,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    height: size.height * 0.45,
                    margin: const EdgeInsets.only(
                      left: Spacing.large,
                      right: Spacing.large,
                    ),
                    width: size.width,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _userController,
                            decoration: InputDecoration(
                              hintText: 'Ingrese su texto',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              filled: true,
                              fillColor: AppColors.whiteBone,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, ingrese un usuario';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: Spacing.medium),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Ingrese su texto',
                              prefixIcon: const Icon(Icons.key_sharp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              filled: true,
                              fillColor: AppColors.whiteBone,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, ingrese un usuario';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                MyElevatedButton(
                  width: size.width * 0.9,
                  height: 50.0,
                  onPressed: () async {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      String user = _userController.text;
                      String password = _passwordController.text;
                      await Provider.of<LoginViewModel>(context, listen: false)
                          .login(
                        user,
                        password,
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.orange[200]!, Colors.orange[800]!],
                  ),
                  child: const Text('SIGN IN'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
