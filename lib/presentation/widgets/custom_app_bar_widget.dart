import 'package:flutter/material.dart';
import 'package:wanza_express/core/util/navigator_service.dart';
import 'package:wanza_express/presentation/widgets/custom_image_view.dart';

import '../../core/image_constants.dart';
import '../../core/util/dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final bool showActionButton;
  final Function()? onBackPressed;
  final bool centerTitle;
  final double? fontSize;
  final bool showResetIcon;
  final Widget? reset;
  final bool showLogo;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.isBackButtonExist = true,
      this.onBackPressed,
      this.centerTitle = true,
      this.showActionButton = true,
      this.fontSize,
      this.showResetIcon = false,
      this.reset,
      this.showLogo = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
            actions: showResetIcon ? [reset!] : [],
            backgroundColor: Theme.of(context).cardColor,
            toolbarHeight: 50,
            iconTheme: IconThemeData(
                color: Theme.of(context).textTheme.bodyLarge?.color),
            automaticallyImplyLeading: false,
            title: Text(title ?? '',
                // style

                style: theme.textTheme.displayMedium!.copyWith(
                  fontSize: fontSize ?? 18,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis),
            centerTitle: centerTitle,
            excludeHeaderSemantics: true,
            titleSpacing: 0,
            elevation: 1,
            clipBehavior: Clip.none,
            shadowColor: Theme.of(context).primaryColor.withAlpha(1),
            leadingWidth: isBackButtonExist ? 50 : 120,
            leading: isBackButtonExist
                ? IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.color
                            ?.withAlpha(75)),
                    onPressed: () => onBackPressed != null
                        ? onBackPressed!()
                        : Navigator.pop(context))
                : showLogo
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: Dimensions.paddingSizeDefault,
                        ),
                        child: SizedBox(
                          child: CustomImageView(
                            imagePath: ImageConstant.wanzaLogo,
                            fit: BoxFit.cover,
                          ),
                        ))
                    : const SizedBox()));
  }

  @override
  Size get preferredSize => Size(
      MediaQuery.of(NavigatorService.navigatorKey.currentState!.context)
          .size
          .width,
      50);
}
