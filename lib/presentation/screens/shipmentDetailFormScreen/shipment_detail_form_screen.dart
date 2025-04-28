import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wanza_express/core/util/navigator_service.dart';
import 'package:wanza_express/data/models/create_receiver_shipment_info_model.dart';
import 'package:wanza_express/data/models/creating_shipment_sender_model.dart';
import 'package:wanza_express/domain/auth_provider.dart';
import 'package:wanza_express/presentation/screens/shipmentDetailFormScreen/widgets/sender_detail_information_screen.dart';
import 'package:wanza_express/presentation/widgets/custom_image_view.dart';

import '../../../core/image_constants.dart';
import '../../../core/util/progress_dialog_utils.dart';
import '../../../data/models/shipment_detail_model.dart';
import '../../../data/models/shipment_initiate_model.dart';
import 'widgets/from_to_widgets.dart';
import 'widgets/items_information_screen.dart';
import 'widgets/payment_information_widget.dart';
import 'widgets/reciver_detail_screen.dart';
import 'widgets/review_screen.dart';
import 'widgets/shipment_success_widget.dart';

// Add GlobalKeys for each step
final GlobalKey<FormState> fromToFormKey = GlobalKey<FormState>();
final GlobalKey<FormState> senderDetailFormKey = GlobalKey<FormState>();
final GlobalKey<FormState> receiverDetailFormKey = GlobalKey<FormState>();
final GlobalKey<FormState> itemInformationFormKey = GlobalKey<FormState>();
final GlobalKey<FormState> paymentInformationFormKey = GlobalKey<FormState>();

class ShipmentDetailFormScreen extends ConsumerStatefulWidget {
  const ShipmentDetailFormScreen({super.key});

  static Widget builder(BuildContext context) =>
      const ShipmentDetailFormScreen();

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<ShipmentDetailFormScreen> {
  int currentStep = 1;
  List<String> titles = [];
  String? shipmentDirection;
  String? selectedOption;

  // Shared instance of ShipmentInitiateModel
  final ShipmentInitiateModel shipmentInitiateModel = ShipmentInitiateModel();
  final SenderShipmentDetailModel createsenderShipmentDetailModel =
      SenderShipmentDetailModel();
  final SenderShipmentDetailModel receiverShipmentDetailModel =
      SenderShipmentDetailModel();
  final CreateReceiverShipmentDetailModel createReceiverShipmentDetailModel =
      CreateReceiverShipmentDetailModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null) {
        selectedOption = args['option'];
        shipmentDirection = args['direction'];

        // Adjust titles based on the selected option and direction
        if (selectedOption == 'Create Shipment') {
          titles = [
            "From/To",
            "Sender Detail",
            "Receiver Detail",
            "Item Information",
            "Payment Information",
            "Shipment Detail Review",
            "Shipment Done",
          ];
        } else if (selectedOption == 'Credit Shipment') {
          if (shipmentDirection == 'Sender') {
            titles = [
              "From/To",
              "Receiver Detail",
              "Item Information",
              "Payment Information",
              "Shipment Detail Review",
              "Shipment Done",
            ];
          } else if (shipmentDirection == 'Receiver') {
            titles = [
              "From/To",
              "Sender Detail",
              "Item Information",
              "Payment Information",
              "Shipment Detail Review",
              "Shipment Done",
            ];
          } else if (shipmentDirection == 'Both') {
            titles = [
              "From/To",
              "Item Information",
              "Payment Information",
              "Shipment Detail Review",
              "Shipment Done",
            ];
          }
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sharedShipmentState = ref.watch(sharedShipmentStateProvider);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
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
            // Progress bar and step title
            Container(
              height: 72,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffFFFEE6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  // Circular progress bar
                  Stack(
                    children: [
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: CircularProgressIndicator.adaptive(
                          value: currentStep / titles.length,
                          strokeWidth: 7,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.primaryColor,
                          ),
                          backgroundColor: const Color(0xff424242),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "$currentStep of ${titles.length}",
                            style: theme.textTheme.bodySmall!.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  // Step title
                  Text(
                    titles[currentStep - 1],
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 21),
            // Render screens dynamically based on currentStep
            buildPages(),
            const SizedBox(height: 40),
            // Back and Next buttons
            if (currentStep != titles.length)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 53,
                        child: ElevatedButton(
                          onPressed: currentStep > 1
                              ? () {
                                  setState(() {
                                    currentStep--;
                                  });
                                }
                              : () {
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
                        height: 53,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (await validateAndProceed(sharedShipmentState)) {
                              // Call REST API here if needed
                              await callApiForCurrentStep();
                            }
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
              ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Future<bool> validateAndProceed(
      ShipmentDetailModel? sharedShipmentState) async {
    // Validate the form for the current step
    switch (titles[currentStep - 1]) {
      case "From/To":
        if (fromToFormKey.currentState?.validate() ?? false) {
          try {
            setState(() {
              shipmentInitiateModel.isBulkShipment ??= false;
              shipmentInitiateModel.destinationCountryCode ??=
                  shipmentInitiateModel.originCountryCode;
              shipmentInitiateModel.serviceTypeId ??= 1;
            });
            ProgressDialogUtils.showProgressDialog(
              context: NavigatorService.navigatorKey.currentState!.context,
            );
            await Future.wait([
              ref
                  .read(sharedShipmentStateProvider.notifier)
                  .initiateShipmentDetails(shipmentInitiateModel),
            ]);
            final sharedShipmentState = ref.watch(sharedShipmentStateProvider);
            if (sharedShipmentState != null) {
              ProgressDialogUtils.hideProgressDialog();
              setState(() {
                createsenderShipmentDetailModel.orderId =
                    sharedShipmentState.id.toString();
                currentStep++;
              });
            } else {
              ProgressDialogUtils.hideProgressDialog();
              ProgressDialogUtils.showSnackBar(
                message: "Something went wrong, please try again later.",
              );
              return false;
            }
          } catch (e, s) {
            debugPrint("Error: $e\nStackTrace: $s");
            ProgressDialogUtils.showSnackBar(
              message: "Error occurred while validating shipment direction",
            );
            return false;
          }
        }
        break;
      case "Sender Detail":
        if (senderDetailFormKey.currentState?.validate() ?? false) {
          try {
            if (mounted) {
              ProgressDialogUtils.showProgressDialog(
                context: NavigatorService.navigatorKey.currentState!.context,
              );
            }
            await Future.wait([
              ref
                  .read(sharedShipmentStateProvider.notifier)
                  .updateSenderDetails(createsenderShipmentDetailModel),
            ]);
            final sharedShipmentState = ref.watch(sharedShipmentStateProvider);
            if (sharedShipmentState != null &&
                sharedShipmentState.sender != null) {
              ProgressDialogUtils.hideProgressDialog();
              setState(() {
                createReceiverShipmentDetailModel.orderId =
                    sharedShipmentState.id.toString();
                createReceiverShipmentDetailModel.countryCode =
                    sharedShipmentState.route?.destinationCountryCode ?? "ET";
                createReceiverShipmentDetailModel.cityId =
                    sharedShipmentState.route?.destinationCityId;
                currentStep++;
              });
            } else {
              ProgressDialogUtils.hideProgressDialog();
              ProgressDialogUtils.showSnackBar(
                message: "Error occurred while validating shipment direction",
              );
              return false;
            }
          } catch (e, s) {
            debugPrint("Error: $e\nStackTrace: $s");
            ProgressDialogUtils.showSnackBar(
              message: "Error occurred while validating shipment direction",
            );
            return false;
          }
        }
        break;
      case "Receiver Detail":
        if (receiverDetailFormKey.currentState?.validate() ?? false) {
          try {
            if (mounted) {
              ProgressDialogUtils.showProgressDialog(
                context: NavigatorService.navigatorKey.currentState!.context,
              );
            }
            await Future.wait([
              ref
                  .read(sharedShipmentStateProvider.notifier)
                  .updateReceiverDetails(createReceiverShipmentDetailModel),
            ]);
            final sharedShipmentState = ref.watch(sharedShipmentStateProvider);
            if (sharedShipmentState != null &&
                sharedShipmentState.recipient != null) {
              ProgressDialogUtils.hideProgressDialog();
              setState(() {
                currentStep++;
              });
            } else {
              ProgressDialogUtils.hideProgressDialog();
              ProgressDialogUtils.showSnackBar(
                message: "Error occurred while validating shipment direction",
              );
              return false;
            }
          } catch (e, s) {
            debugPrint("Error: $e\nStackTrace: $s");
            ProgressDialogUtils.showSnackBar(
              message: "Error occurred while validating shipment direction",
            );
            return false;
          }
        }
        break;
      case "Item Information":
        if (itemInformationFormKey.currentState?.validate() ?? false) {
          setState(() {
            currentStep++;
          });
          return true;
        }
        break;
      case "Payment Information":
        if (paymentInformationFormKey.currentState?.validate() ?? false) {
          setState(() {
            currentStep++;
          });
          return true;
        }
        break;
      default:
        setState(() {
          currentStep++;
        });
        return true;
    }
    return false;
  }

  Future<void> callApiForCurrentStep() async {
    // Call the REST API for the current step
    switch (titles[currentStep - 1]) {
      case "From/To":
        break;
      case "Sender Detail":
        // Call API for Sender Detail step
        break;
      case "Receiver Detail":
        // Call API for Receiver Detail step
        break;
      case "Item Information":
        // Call API for Item Information step
        break;
      case "Shipment Detail Review":
        // Call API for Shipment Detail Review step
        break;
      case "Payment Information":
        // Call API for Shipment Detail Review step
        break;
      case "Shipment Done":
        // Call API for Shipment Done step
        break;
    }
  }

  Widget buildPages() {
    switch (titles[currentStep - 1]) {
      case "From/To":
        return ShipmentDirectionInfoWidget(
          shipmentInitiateModel: shipmentInitiateModel,
        );
      case "Sender Detail":
        return SenderDetailScreen(
          senderShipmentDetailModel: createsenderShipmentDetailModel,
        );
      case "Receiver Detail":
        return ReceiverDetailScreen(
          receiverShipmentDetailModel: createReceiverShipmentDetailModel,
        );
      case "Item Information":
        return const ItemsInformationScreen();
      case "Payment Information":
        return CreatingShipmentPaymentInformationScreen(
          receiverShipmentDetailModel: receiverShipmentDetailModel,
        );
      case "Shipment Detail Review":
        return const ShipmentReviewScreen();
      case "Shipment Done":
        return const ShipmentSuccussScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}
