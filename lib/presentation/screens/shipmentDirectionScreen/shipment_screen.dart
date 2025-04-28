import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanza_express/core/util/flutter_scure_storege_utils.dart';
import 'package:wanza_express/core/util/navigator_service.dart';
import 'package:wanza_express/presentation/routes.dart';
import 'package:wanza_express/presentation/widgets/custom_image_view.dart';
import '../../../core/image_constants.dart';
import '../../widgets/custom_DropdownFormField.dart';

class ShipmentScreen extends ConsumerStatefulWidget {
  const ShipmentScreen({super.key});

  static Widget builder(BuildContext context) => const ShipmentScreen();

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<ShipmentScreen> {
  bool isWalletDataLoading = false;
  String? _selectedCompany;
  String? _shipmentDirection;
  final _shipmentDirections = ['Sender', 'Receiver', 'Both'];
  final _companies = ['Company A', 'Company B', 'Company C'];

  @override
  void initState() {
    super.initState();
    // Automatically load wallet data and fetch user's full name
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.wait([]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 50),
              // Wanza logo
              Center(
                child: CustomImageView(
                  imagePath: ImageConstant.wanzaLogo,
                  width: 104,
                  height: 26,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 21),
              // Back button with screen title in row
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      NavigatorService.goBack();
                    },
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Credit Shipment",
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontSize: 16,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 38),
              // Dropdown for company selection
              Text(
                "Company",
                style: theme.textTheme.bodySmall!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              CustomDropdownFormField<String>(
                value: _selectedCompany,
                items: _companies
                    .map((company) => DropdownMenuItem<String>(
                          value: company,
                          child: Text(company),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCompany = value;
                  });
                },
                hint: Text(
                  "Select Company",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                ),
                isExpanded: true,
              ),
              const SizedBox(height: 30),
              // Dropdown for shipment direction selection
              Text(
                "Shipment Direction",
                style: theme.textTheme.bodySmall!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              CustomDropdownFormField<String>(
                value: _shipmentDirection,
                items: _shipmentDirections
                    .map((direction) => DropdownMenuItem<String>(
                          value: direction,
                          child: Text(direction),
                        ))
                    .toList(),
                onChanged: (value) async {
                  setState(() {
                    _shipmentDirection = value;
                  });
                  await FlutterSecureStorageUtils.saveValue(
                    'shipmentDirection',
                    value.toString(),
                  );
                },
                hint: Text(
                  "Select Shipment Direction",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                ),
                isExpanded: true,
              ),
              const SizedBox(height: 56),
              // Back and Next buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 43,
                      child: ElevatedButton(
                        onPressed: () {
                          NavigatorService.goBack();
                        },
                        style: theme.elevatedButtonTheme.style!.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.black,
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
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Back",
                            style: theme.textTheme.titleMedium!.copyWith(
                              fontSize: 16,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 43,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_shipmentDirection == null ||
                              _selectedCompany == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please select both company and shipment direction.",
                                ),
                              ),
                            );
                            return;
                          }

                          // Navigate to the next screen based on the selected direction
                          NavigatorService.pushNamed(
                            AppRoutes.shipmentDetailFormScreen,
                            arguments: {
                              'option': 'Credit Shipment',
                              'direction': _shipmentDirection,
                              'company': _selectedCompany,
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
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Next",
                            style: theme.textTheme.titleMedium!.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
