import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remittance_app/core/image_constants.dart';
import 'package:remittance_app/core/util/navigator_service.dart';
import 'package:remittance_app/presentation/routes.dart';
import 'package:remittance_app/presentation/widgets/custom_image_view.dart';
import 'package:remittance_app/presentation/widgets/custom_text_form_field.dart';
import '../../../core/util/input_Validators.dart';
// import '../../../core/util/progress_dialog_utils.dart';
// import '../../../domain/auth_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();

  static Widget builder(BuildContext context) => const AuthScreen();
}

class AuthScreenState extends ConsumerState<AuthScreen> {
  // final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // bool _isLogin = true;

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 80),
                CustomImageView(
                  imagePath: ImageConstant.tracksloadIogo,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 83),
                CustomTextFormField(
                  controller: _emailController,
                  autofocus: false,
                  isPhoneNumber: true,
                  hintText: "Email or Phone Number",
                  validator: (value) =>
                      InputValidators.validatePhoneNumber(value ?? ""),
                ),
                const SizedBox(height: 13),
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
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.only(right: 0),
                      textStyle: Theme.of(context).textTheme.titleSmall,
                    ),
                    child: Text(
                      'Forgot your password?',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                const SizedBox(height: 44),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () async {
                      // here
                      NavigatorService.pushNamedAndRemoveUntil(
                          AppRoutes.dashboardScreen);
                      // if (_formKey.currentState!.validate()) {
                      //   // Show progress dialog
                      //   ProgressDialogUtils.showProgressDialog(
                      //     context: context,
                      //     isCancellable: false,
                      //   );
                      //   final fullname = _fullNameController.text;
                      //   final email = _emailController.text;
                      //   final password = _passwordController.text;
                      //   try {
                      //     if (_isLogin) {
                      //       await ref
                      //           .read(authProvider.notifier)
                      //           .login(email, password);
                      //     } else {
                      //       await ref
                      //           .read(authProvider.notifier)
                      //           .register(fullname, email, password);
                      //     }
                      //     // Check the state after login or registration
                      //     if (mounted) {
                      //       ProgressDialogUtils
                      //           .hideProgressDialog(); // Hide progress dialog
                      //       final authState = ref.read(authProvider);
                      //       if (authState.isLoggedIn) {
                      //         // Navigate to the wallet screen if logged in
                      //         NavigatorService.pushNamedAndRemoveUntil(
                      //             AppRoutes.dashboardScreen);
                      //       } else if (authState.error != null) {
                      //         // Show error message
                      //         ProgressDialogUtils.showSnackBar(
                      //           message: authState.error!,
                      //         );
                      //       }
                      //     }
                      //   } catch (e) {
                      //     // Handle unexpected errors
                      //     if (mounted) {
                      //       ProgressDialogUtils.hideProgressDialog();
                      //       ProgressDialogUtils.showSnackBar(
                      //         message: 'An unexpected error occurred.',
                      //       );
                      //     }
                      //   } finally {
                      //     // Ensure the progress dialog is hidden in all cases
                      //     if (mounted) {
                      //       ProgressDialogUtils.hideProgressDialog();
                      //     }
                      //   }
                      // }
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: const Text("Login"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an Account?",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Request an Inviatation",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ],
                ),
                //  or login with google
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 220,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {},
                    style:
                        Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.google,
                          height: 44,
                          width: 44,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Login with Google",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
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
