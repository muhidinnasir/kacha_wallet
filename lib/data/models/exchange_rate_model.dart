class ExchangeRateState {
  final Map<String, double> rates;
  final bool isLoading;
  final String? error;

  ExchangeRateState({
    required this.rates,
    required this.isLoading,
    this.error,
  });

  factory ExchangeRateState.initial() {
    return ExchangeRateState(rates: {}, isLoading: false, error: null);
  }
}
