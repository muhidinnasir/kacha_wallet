import 'package:flutter/material.dart';
import 'package:wanza_express/data/repositories/api_service.dart';

import '../../../core/image_constants.dart';
import '../../../core/util/flutter_scure_storege_utils.dart';
import '../../../core/util/navigator_service.dart';
import '../../routes.dart';
import '../../widgets/custom_image_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();

  static Widget builder(BuildContext context) {
    return const SplashScreen();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () async {
      // Check if the user is logged in by checking the presence of the token
      final isLoggedIn =
          await FlutterSecureStorageUtils.getValue("id_token") == null ||
                  await FlutterSecureStorageUtils.getValue("id_token") == ""
              ? false
              : true;
      if (isLoggedIn) {
        // check if the user access token is expired
        final isExpired = await ApiService.isAccessTokenExpired();
        if (isExpired) {
          // If the token is expired, navigate to the login screen
          NavigatorService.pushNamedAndRemoveUntil(
            AppRoutes.authScreen,
          );
          return;
        }
        NavigatorService.pushNamedAndRemoveUntil(
          AppRoutes.dashboardScreen,
        );
      } else {
        NavigatorService.pushNamedAndRemoveUntil(
          AppRoutes.authScreen,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: CustomImageView(
                    imagePath: ImageConstant.wanzaLogo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
