import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../data/models/exchange_rate_model.dart';

class ExchangeRateNotifier extends StateNotifier<ExchangeRateState> {
  ExchangeRateNotifier() : super(ExchangeRateState.initial());

  Future<void> fetchExchangeRates() async {
    state = ExchangeRateState(rates: state.rates, isLoading: true);

    const apiUrl = 'https://open.er-api.com/v6/latest/USD'; // Free API endpoint
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rawRates = Map<String, dynamic>.from(data['rates']);
        final rates = rawRates.map<String, double>(
          (key, value) =>
              MapEntry(key, value is int ? value.toDouble() : value),
        );

        state = ExchangeRateState(rates: rates, isLoading: false);
      } else {
        state = ExchangeRateState(
          rates: state.rates,
          isLoading: false,
          error: 'Failed to fetch exchange rates.',
        );
      }
    } catch (e, s) {
      debugPrint('Error fetching exchange rates: $e, $s');
      state = ExchangeRateState(
        rates: state.rates,
        isLoading: false,
        error: 'Something went wrong: $e',
      );
    }
  }
}

final exchangeRateProvider =
    StateNotifierProvider<ExchangeRateNotifier, ExchangeRateState>(
  (ref) => ExchangeRateNotifier(),
);
