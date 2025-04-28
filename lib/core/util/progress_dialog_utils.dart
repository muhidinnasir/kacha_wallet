import 'package:flutter/material.dart';

import 'navigator_service.dart';

class ProgressDialogUtils {
  static bool isProgressVisible = false;

  ///common method for showing progress dialog
  static void showProgressDialog(
      {BuildContext? context, isCancellable = false}) async {
    if (!isProgressVisible &&
        NavigatorService.navigatorKey.currentState?.overlay?.context != null) {
      showDialog(
          barrierDismissible: isCancellable,
          context: NavigatorService.navigatorKey.currentState!.overlay!.context,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            );
          });
      isProgressVisible = true;
    }
  }

  ///common method for hiding progress dialog
  static void hideProgressDialog() {
    if (isProgressVisible) {
      Navigator.pop(
          NavigatorService.navigatorKey.currentState!.overlay!.context);
    }
    isProgressVisible = false;
  }

  static void showSnackBar({required String message}) {
    ScaffoldMessenger.of(NavigatorService.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        duration: const Duration(seconds: 4),
        backgroundColor:
            Theme.of(NavigatorService.navigatorKey.currentState!.context)
                .colorScheme
                .primary,
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom:
              MediaQuery.of(NavigatorService.navigatorKey.currentState!.context)
                      .size
                      .height -
                  100,
          left: 10,
          right: 10,
        ),
        // Adjust the duration as needed
      ),
    );
  }
}
