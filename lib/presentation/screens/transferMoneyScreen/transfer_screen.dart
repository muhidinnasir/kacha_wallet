import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanza_express/core/util/input_Validators.dart';
import '../../widgets/custom_DropdownFormField.dart';
import '../../widgets/custom_text_form_field.dart';

class TransferScreen extends ConsumerStatefulWidget {
  static Widget builder(BuildContext context) => const TransferScreen();

  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final _recipientController = TextEditingController();
  final _emailController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();

  String? _selectedBank;
  String? _selectedCurrency;
  final _banks = ['Bank A', 'Bank B', 'Bank C'];
  final _currencies = ['USD', 'EUR', 'ETB'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Money"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                autofocus: false,
                controller: _recipientController,
                hintText: "Recipient Name",
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                autofocus: false,
                controller: _emailController,
                hintText: "Recipient Email",
                validator: (value) =>
                    InputValidators.validateEmail(value ?? ''),
              ),
              const SizedBox(height: 16),
              CustomDropdownFormField<String>(
                value: _selectedCurrency,
                items: _currencies
                    .map((currency) => DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value;
                  });
                },
                hint: const Text("Select Currency"),
              ),
              const SizedBox(height: 16),
              CustomDropdownFormField<String>(
                value: _selectedBank,
                items: _banks
                    .map((bank) => DropdownMenuItem<String>(
                          value: bank,
                          child: Text(bank),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBank = value;
                  });
                },
                hint: const Text("Select Bank"),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                autofocus: false,
                controller: _accountNumberController,
                hintText: "Account Number",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                autofocus: false,
                controller: _amountController,
                hintText: "Amount",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () async {},
                  child: const Text("Send Money"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
