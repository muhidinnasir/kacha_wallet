import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remittance_app/core/image_constants.dart';
import 'package:remittance_app/core/util/navigator_service.dart';
import 'package:remittance_app/presentation/routes.dart';
import 'package:remittance_app/presentation/widgets/custom_image_view.dart';
import 'package:remittance_app/presentation/widgets/custom_text_form_field.dart';
import '../../../core/util/input_Validators.dart';
import '../../../core/util/progress_dialog_utils.dart';
import '../../../domain/auth_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();

  static Widget builder(BuildContext context) => const AuthScreen();
}

class AuthScreenState extends ConsumerState<AuthScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;

  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                CustomImageView(
                  imagePath: ImageConstant.appLogo,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _isLogin
                        ? 'Login to Kacha Wallet'
                        : 'Register to Kacha Wallet',
                  ),
                ),
                if (!_isLogin) ...[
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _fullNameController,
                    autofocus: false,
                    hintText: "Full Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Full Name is required';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _emailController,
                  autofocus: false,
                  hintText: "Email",
                  validator: (value) =>
                      InputValidators.validateEmail(value ?? ""),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _passwordController,
                  autofocus: false,
                  obscureText: _isPasswordVisible,
                  hintText: "Password",
                  validator: (value) =>
                      InputValidators.validatePassword(value ?? ""),
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(30, 13, 8, 13),
                      child: _isPasswordVisible
                          ? Icon(Icons.visibility_off_rounded,
                              color: Theme.of(context).iconTheme.color)
                          : Icon(Icons.visibility,
                              color: Theme.of(context).iconTheme.color),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Show progress dialog
                        ProgressDialogUtils.showProgressDialog(
                          context: context,
                          isCancellable: false,
                        );

                        final fullname = _fullNameController.text;
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        try {
                          if (_isLogin) {
                            await ref
                                .read(authProvider.notifier)
                                .login(email, password);
                          } else {
                            await ref
                                .read(authProvider.notifier)
                                .register(fullname, email, password);
                          }

                          // Check the state after login or registration
                          if (mounted) {
                            ProgressDialogUtils
                                .hideProgressDialog(); // Hide progress dialog

                            final authState = ref.read(authProvider);
                            if (authState.isLoggedIn) {
                              // Navigate to the wallet screen if logged in
                              NavigatorService.pushNamedAndRemoveUntil(
                                  AppRoutes.dashboardScreen);
                            } else if (authState.error != null) {
                              // Show error message
                              ProgressDialogUtils.showSnackBar(
                                message: authState.error!,
                              );
                            }
                          }
                        } catch (e) {
                          // Handle unexpected errors
                          if (mounted) {
                            ProgressDialogUtils.hideProgressDialog();
                            ProgressDialogUtils.showSnackBar(
                              message: 'An unexpected error occurred.',
                            );
                          }
                        } finally {
                          // Ensure the progress dialog is hidden in all cases
                          if (mounted) {
                            ProgressDialogUtils.hideProgressDialog();
                          }
                        }
                      }
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Text(_isLogin ? "Login" : "Register"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? "Don't have an account? Register"
                        : "Already have an account? Login",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
