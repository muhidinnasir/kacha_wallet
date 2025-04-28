import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanza_express/presentation/routes.dart';
import 'package:wanza_express/presentation/widgets/custom_image_view.dart';
import '../../../core/image_constants.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  static Widget builder(BuildContext context) => const DashboardScreen();

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          // Wanza logo
          CustomImageView(
            imagePath: ImageConstant.wanzaLogo,
            width: 104,
            height: 26,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 68),
          Text(
            "Welcome!",
            style: theme.textTheme.titleLarge!.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 38),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  color: theme.textTheme.bodyLarge?.color,
                ),
                children: const [
                  TextSpan(
                    text:
                        'To initiate a regular shipment with immediate payment, please select ',
                  ),
                  TextSpan(
                    text: '“Create Shipment.”',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' For a credit shipment, kindly click on '),
                  TextSpan(
                    text: '“Create Credit Shipment.”',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 56),
          // Create Shipment Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SizedBox(
              height: 64,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.shipmentDetailFormScreen,
                    arguments: {
                      'option': 'Create Shipment',
                      'direction': 'Both', // Default direction
                    },
                  );
                },
                style: theme.elevatedButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateProperty.all(
                    theme.primaryColor,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_outward_rounded,
                      color: Colors.black,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Create Shipment",
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Create Credit Shipment Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SizedBox(
              height: 64,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.createshipmentScreen,
                    arguments: {
                      'option': 'Credit Shipment',
                      'direction': 'Sender', // Default direction
                    },
                  );
                },
                style: theme.elevatedButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_outward_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Create Credit Shipment",
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
