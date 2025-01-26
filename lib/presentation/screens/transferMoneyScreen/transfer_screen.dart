import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remittance_app/core/util/input_Validators.dart';
import '../../../core/util/navigator_service.dart';
import '../../../core/util/progress_dialog_utils.dart';
import '../../../domain/wallet_provider.dart';
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
    final walletNotifier = ref.read(walletProvider.notifier);
    final isTransactionLoading = walletNotifier.isTransactionInProgress;
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
                  onPressed: isTransactionLoading
                      ? null
                      : () async {
                          final recipient = _recipientController.text;
                          final email = _emailController.text;
                          final accountNumber = _accountNumberController.text;
                          final amount =
                              double.tryParse(_amountController.text);

                          if (recipient.isEmpty ||
                              email.isEmpty ||
                              accountNumber.isEmpty ||
                              amount == null ||
                              amount <= 0 ||
                              _selectedBank == null ||
                              _selectedCurrency == null) {
                            ProgressDialogUtils.showSnackBar(
                              message: "Invalid input!",
                            );
                            return;
                          }
                          ProgressDialogUtils.showProgressDialog(
                            context: context,
                            isCancellable: false,
                          );
                          await walletNotifier.sendMoney(
                            recipient,
                            amount,
                            currency: _selectedCurrency!,
                            bank: _selectedBank!,
                            accountNumber: accountNumber,
                          );
                          if (mounted) {
                            ProgressDialogUtils.showSnackBar(
                              message: "Transaction Successful!",
                            );
                          }
                          ProgressDialogUtils.hideProgressDialog();
                          NavigatorService.goBack(); // Navigate back
                        },
                  child: isTransactionLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Send Money"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
