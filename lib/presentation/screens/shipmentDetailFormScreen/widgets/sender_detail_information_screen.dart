import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/creating_shipment_sender_model.dart';
import '../../../../domain/auth_provider.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../shipment_detail_form_screen.dart';

class SenderDetailScreen extends ConsumerStatefulWidget {
  final SenderShipmentDetailModel senderShipmentDetailModel;
  const SenderDetailScreen(
      {super.key, required this.senderShipmentDetailModel});

  @override
  ConsumerState<SenderDetailScreen> createState() =>
      _ReceiverDetailScreenState();
}

class _ReceiverDetailScreenState extends ConsumerState<SenderDetailScreen> {
  String? selectedCountry;
  String? selectedCity;
  String? selectedSubCity;
  String? cityId;
  String? countryCode;

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _fristnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

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
        selectedSubCity = "Sub City";
        widget.senderShipmentDetailModel.countryCode = countryCode;
        widget.senderShipmentDetailModel.cityId = int.tryParse(cityId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Form(
      key: senderDetailFormKey,
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
                hintText: "Company Name",
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the company name
                  setState(() {
                    widget.senderShipmentDetailModel.companyName = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30), // Add some space at the top
              // Recipient's Name
              _buildSectionHeader("First Name", isRequired: true),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                controller: _fristnameController,
                hintText: "First Name",
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the first name
                  setState(() {
                    widget.senderShipmentDetailModel.firstName = value;
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
              _buildSectionHeader("Last Name", isRequired: true),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                controller: _lastnameController,
                hintText: "Last Name",
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the last name
                  setState(() {
                    widget.senderShipmentDetailModel.lastName = value;
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
              _buildSectionHeader("Country", isRequired: true),
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
                    widget.senderShipmentDetailModel.countryCode = countryCode;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),
              // Recipient's City
              _buildSectionHeader("City", isRequired: true),
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
                    widget.senderShipmentDetailModel.cityId =
                        int.tryParse(cityId!);
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),
              // Recipient's Sub City
              _buildSectionHeader("Sub City", isRequired: false),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: selectedSubCity ?? "Loading...",
                readOnly: false,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the sub city
                  setState(() {
                    widget.senderShipmentDetailModel.subcity = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),

              // Recipient's house number
              _buildSectionHeader("House Number", isRequired: false),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: "House Number",
                textInputType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the house number
                  setState(() {
                    widget.senderShipmentDetailModel.houseNumber = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),

              // Recipient's Phone Number
              _buildSectionHeader("Phone Number", isRequired: true),
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
                    widget.senderShipmentDetailModel.phoneNumber = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 30),
              // Recipient's Email
              _buildSectionHeader("Email", isRequired: false),
              const SizedBox(height: 6),
              CustomTextFormField(
                autofocus: false,
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                fillColor: const Color(0xffE7E7E7),
                filled: true,
                onChanged: (value) {
                  // Handle changes to the email
                  setState(() {
                    widget.senderShipmentDetailModel.email = value;
                  });
                },
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              const SizedBox(height: 20),

              // // Notify the Receiver
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Checkbox(
              //       value: isChecked,
              //       onChanged: (value) {
              //         // Handle checkbox state
              //         setState(() {
              //           isChecked = value!;
              //         });
              //       },
              //       activeColor: theme.primaryColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(4),
              //       ),
              //     ),
              //     Text(
              //       "Notify the Receiver",
              //       style: theme.textTheme.bodyLarge!.copyWith(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //   ],
              // ),
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
