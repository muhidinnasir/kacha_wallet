import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/exchange_rate_provider.dart';
import '../../widgets/custom_DropdownFormField.dart';
import '../../widgets/custom_text_form_field.dart';

class ExchangeRateScreen extends ConsumerStatefulWidget {
  static Widget builder(BuildContext context) => const ExchangeRateScreen();

  const ExchangeRateScreen({super.key});

  @override
  ConsumerState<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends ConsumerState<ExchangeRateScreen> {
  final TextEditingController _amountController = TextEditingController();
  String? _sourceCurrency = 'USD'; // Default source currency
  String? _targetCurrency = 'EUR'; // Default target currency
  double? _convertedAmount;

  @override
  void initState() {
    super.initState();

    // Fetch exchange rates when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(exchangeRateProvider.notifier).fetchExchangeRates();
    });
  }

  @override
  Widget build(BuildContext context) {
    final exchangeRateState = ref.watch(exchangeRateProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Currency Converter"),
        centerTitle: true,
      ),
      body: exchangeRateState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomDropdownFormField<String>(
                          value: _sourceCurrency,
                          items: exchangeRateState.rates.keys
                              .map((currency) => DropdownMenuItem<String>(
                                    value: currency,
                                    child: Text(currency),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _sourceCurrency = value;
                              _updateConvertedAmount(exchangeRateState.rates);
                            });
                          },
                          label: "Source Currency",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomDropdownFormField<String>(
                          value: _targetCurrency,
                          items: exchangeRateState.rates.keys
                              .map((currency) => DropdownMenuItem<String>(
                                    value: currency,
                                    child: Text(currency),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _targetCurrency = value;
                              _updateConvertedAmount(exchangeRateState.rates);
                            });
                          },
                          label: "Target Currency",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    autofocus: false,
                    controller: _amountController,
                    label: "Amount",
                    textInputType: TextInputType.number,
                    onChanged: (_) =>
                        _updateConvertedAmount(exchangeRateState.rates),
                  ),
                  const SizedBox(height: 24),
                  if (_convertedAmount != null)
                    Text(
                      "Converted Amount: $_convertedAmount $_targetCurrency",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  if (exchangeRateState.error != null)
                    Text(
                      exchangeRateState.error!,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                ],
              ),
            ),
    );
  }

  void _updateConvertedAmount(Map<String, double> rates) {
    final sourceAmount = double.tryParse(_amountController.text);

    if (sourceAmount == null ||
        _sourceCurrency == null ||
        _targetCurrency == null) {
      setState(() {
        _convertedAmount = null;
      });
      return;
    }

    final sourceRate = rates[_sourceCurrency] ?? 1.0;
    final targetRate = rates[_targetCurrency] ?? 1.0;

    setState(() {
      _convertedAmount = (sourceAmount / sourceRate) * targetRate;
    });
  }
}
