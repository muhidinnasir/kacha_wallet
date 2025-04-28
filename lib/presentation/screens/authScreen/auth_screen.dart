import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanza_express/core/image_constants.dart';
import 'package:wanza_express/core/util/navigator_service.dart';
import 'package:wanza_express/data/repositories/api_service.dart';
import 'package:wanza_express/presentation/widgets/custom_image_view.dart';
import 'package:wanza_express/presentation/widgets/custom_text_form_field.dart';
import '../../../core/util/input_Validators.dart';

import '../../../core/util/progress_dialog_utils.dart';
import '../../routes.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();

  static Widget builder(BuildContext context) => const AuthScreen();
}

class AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = true;

  Future<void> login() async {
    try {
      ProgressDialogUtils.showProgressDialog(
        context: NavigatorService.navigatorKey.currentState!.overlay!.context,
        isCancellable: false,
      );
      // logic to login the user
      // For example, you can call a login API here
      // and handle the response accordingly.
      final response = await ApiService().loginWithKeycloak();
      if (response == false) {
        ProgressDialogUtils.hideProgressDialog();
        if (mounted) {
          ProgressDialogUtils.showSnackBar(
            message: 'Login failed',
          );
        }
        return;
      }
      ProgressDialogUtils.hideProgressDialog();
      // Navigate to the dashboard screen
      NavigatorService.pushNamedAndRemoveUntil(AppRoutes.dashboardScreen);
    } catch (e, s) {
      debugPrint('Login error: $e, $s');
      ProgressDialogUtils.hideProgressDialog();
      if (mounted) {
        ProgressDialogUtils.showSnackBar(
          message: 'Login failed: $e',
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

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
                  imagePath: ImageConstant.wanzaLogo,
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
                              color: Theme.of(context)
                                  .iconTheme
                                  .copyWith(
                                    color: const Color(0xFFB0B0B0),
                                  )
                                  .color)
                          : Icon(Icons.visibility,
                              color: Theme.of(context)
                                  .iconTheme
                                  .copyWith(
                                    color: const Color(0xFFB0B0B0),
                                  )
                                  .color),
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
                    onPressed: () => login(),
                    style:
                        Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: Colors.grey.shade500,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
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
                              color: const Color(0xff8C8500),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: SizedBox(
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
                                      color: Colors.grey.shade300,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
