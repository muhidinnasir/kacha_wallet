import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/create_receiver_shipment_info_model.dart';
import '../../../../domain/auth_provider.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../shipment_detail_form_screen.dart';

class ReceiverDetailScreen extends ConsumerStatefulWidget {
  final CreateReceiverShipmentDetailModel receiverShipmentDetailModel;
  const ReceiverDetailScreen(
      {super.key, required this.receiverShipmentDetailModel});

  @override
  ConsumerState<ReceiverDetailScreen> createState() =>
      _ReceiverDetailScreenState();
}

class _ReceiverDetailScreenState extends ConsumerState<ReceiverDetailScreen> {
  String? selectedCountry;
  String? selectedCity;
  String? selectedSubCity;
  String? cityId;
  String? countryCode;
  bool isTheReceiverNotify = false;

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _fristnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Future<void> _initializeRecipientDetails() async {
    final receiverDetailState = ref.watch(sharedShipmentStateProvider);
    if (receiverDetailState != null) {
      setState(() {
        _countryController.text =
            receiverDetailState.route?.destinationCountryName ?? "";
        _cityController.text =
            receiverDetailState.route?.destinationCityName ?? "";
        selectedCountry =
            receiverDetailState.route?.destinationCountryName ?? "";
        selectedCity = receiverDetailState.route?.destinationCityName ?? "";
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeRecipientDetails();
  }

  @override
  Widget build(BuildContext context) {
    final recipientModelState = ref.watch(sharedShipmentStateProvider);
    return Form(
      key: receiverDetailFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipient's campany name
              _buildSectionHeader("Company Name"),
              const SizedBox(height: 6),
              CustomTextFormField(
                controller: _companyNameController,
                autofocus: false,
                hintText: "Recipient's Company Name",
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the company name
                  setState(() {
                    widget.receiverShipmentDetailModel.companyName = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30), // Add some space at the top
              // Recipient's Name
              _buildSectionHeader("Recipient's First Name", isRequired: true),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                controller: _fristnameController,
                hintText: "Recipient's First Name",
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the first name
                  setState(() {
                    widget.receiverShipmentDetailModel.firstName = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your first name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              // Recipient's Last Name
              _buildSectionHeader("Recipient's Last Name", isRequired: true),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                controller: _lastnameController,
                hintText: "Recipient's Last Name",
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the last name
                  setState(() {
                    widget.receiverShipmentDetailModel.lastName = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your last name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              // Recipient's Country
              _buildSectionHeader("Recipient's Country", isRequired: true),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: selectedCountry ?? "Loading...",
                controller: _countryController.value.text.isNotEmpty
                    ? _countryController
                    : TextEditingController(text: selectedCountry),
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                readOnly: true,
                onChanged: (value) {
                  // Handle changes to the country
                  setState(() {
                    widget.receiverShipmentDetailModel.countryCode =
                        countryCode;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),
              // Recipient's City
              _buildSectionHeader("Recipient's City", isRequired: true),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: selectedCity ?? "Loading...",
                controller: _cityController.value.text.isNotEmpty
                    ? _cityController
                    : TextEditingController(text: selectedCity),
                readOnly: true,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the city
                  setState(() {
                    widget.receiverShipmentDetailModel.cityId =
                        recipientModelState?.route?.destinationCityId;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),
              // Recipient's Sub City
              _buildSectionHeader("Recipient's Sub City", isRequired: false),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: "Recipient's Sub City",
                readOnly: false,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the sub city
                  setState(() {
                    widget.receiverShipmentDetailModel.subcity = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),

              // Recipient's house number
              _buildSectionHeader("Recipient's House Number",
                  isRequired: false),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: "Recipient's House Number",
                textInputType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the house number
                  setState(() {
                    widget.receiverShipmentDetailModel.houseNumber = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),

              // Recipient's Phone Number
              _buildSectionHeader("Recipient's Phone Number", isRequired: true),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: "+251",
                controller: _phoneNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number";
                  }
                  return null;
                },
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the phone number
                  setState(() {
                    widget.receiverShipmentDetailModel.phoneNumber = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),
              // Recipient's Email
              _buildSectionHeader("Recipient's Email", isRequired: false),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: "Recipient's Email",
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the email
                  setState(() {
                    widget.receiverShipmentDetailModel.email = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 20),

              // Notify the Receiver
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isTheReceiverNotify,
                    onChanged: (value) {
                      setState(() {
                        isTheReceiverNotify = value!;
                        widget.receiverShipmentDetailModel.notifyReceiver =
                            value;
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Text(
                    "Notify the Receiver",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
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
}
