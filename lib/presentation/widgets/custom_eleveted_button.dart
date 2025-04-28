// create custom elevated button stateless widget
//
import 'package:flutter/material.dart';
import 'package:wanza_express/core/util/dimensions.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Widget? child;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        minimumSize: Size(width ?? Dimensions.iconSizeLarge,
            height ?? Dimensions.iconSizeLarge),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: Dimensions.iconSizeLarge,
              width: Dimensions.iconSizeLarge,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
            )
          : child ??
              Text(
                text,
                style: TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  color: textColor ?? Colors.white,
                ),
              ),
    );
  }
}
