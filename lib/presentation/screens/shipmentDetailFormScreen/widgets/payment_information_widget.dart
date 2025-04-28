import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/creating_shipment_sender_model.dart';
import '../../../../domain/auth_provider.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../shipment_detail_form_screen.dart';

class CreatingShipmentPaymentInformationScreen extends ConsumerStatefulWidget {
  final SenderShipmentDetailModel receiverShipmentDetailModel;
  const CreatingShipmentPaymentInformationScreen(
      {super.key, required this.receiverShipmentDetailModel});

  @override
  ConsumerState<CreatingShipmentPaymentInformationScreen> createState() =>
      _ReceiverDetailScreenState();
}

class _ReceiverDetailScreenState
    extends ConsumerState<CreatingShipmentPaymentInformationScreen> {
  String? selectedCountry;
  String? selectedCity;
  String? selectedItemValue;
  String? cityId;
  String? countryCode;
  bool isTheReceiverNotify = false;

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _companyNameController.dispose();
    _countryController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _cityController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeRecipientDetails();
  }

  Future<void> _initializeRecipientDetails() async {
    final currentUserBranchState = ref.read(currentUserBranchsProvider);
    if (currentUserBranchState != null) {
      setState(() {
        selectedCountry = currentUserBranchState.country ?? "";
        countryCode = currentUserBranchState.countryCode ?? "";
        selectedCity = currentUserBranchState.city ?? "";
        cityId = currentUserBranchState.cityId.toString();
        selectedItemValue = "Sub City";
        widget.receiverShipmentDetailModel.countryCode = countryCode;
        widget.receiverShipmentDetailModel.cityId = int.tryParse(cityId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Form(
      key: receiverDetailFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shipment Charge
              _buildSectionHeader("Shipment Charge", isRequired: true),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                readOnly: true,
                hintText: "Enter Shipment Charge",
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // setState(() {
                  //   widget.receiverShipmentDetailModel.shipmentCharge =
                  //       double.tryParse(value);
                  // });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),

              // Negotiated Shipment Charge
              _buildSectionHeader("Negotiated Shipment Charge",
                  isRequired: false),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: "Enter Negotiated Shipment Charge",
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // setState(() {
                  //   widget.receiverShipmentDetailModel
                  //       .negotiatedShipmentCharge = double.tryParse(value);
                  // });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),

              // Insurance Payment Amount
              _buildSectionHeader("Insurance Payment Amount",
                  isRequired: false),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: "Enter Insurance Payment Amount",
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // setState(() {
                  //   widget.receiverShipmentDetailModel.insurancePaymentAmount =
                  //       double.tryParse(value);
                  // });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),

              // Packaging Payment Amount
              _buildSectionHeader("Packaging Payment Amount",
                  isRequired: false),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: "Enter Packaging Payment Amount",
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // setState(() {
                  //   widget.receiverShipmentDetailModel.packagingPaymentAmount =
                  //       double.tryParse(value);
                  // });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),

              // Other Payment Amount
              _buildSectionHeader("Other Payment Amount", isRequired: false),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: "Enter Other Payment Amount",
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // setState(() {
                  //   widget.receiverShipmentDetailModel.otherPaymentAmount =
                  //       double.tryParse(value);
                  // });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 5),
              // divider
              const Divider(
                color: Color(0xffE7E7E7),
                thickness: 1,
              ),
              const SizedBox(height: 10),
              _buildSectionBody("Total Payment", '${23232} ETB'),
              const SizedBox(height: 6),
              _buildSectionBody("VAT", "${15} ETB"),
              const SizedBox(height: 6),
              _buildSectionBody("Grand Total", "${42121} ETB"),
              const SizedBox(height: 10),
              const Divider(
                color: Color(0xffE7E7E7),
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool isRequired = false}) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (isRequired)
          Text(
            "*",
            style: theme.textTheme.bodySmall!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          ),
      ],
    );
  }

  Widget _buildSectionBody(
    String title,
    String value,
  ) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value.toString(),
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
