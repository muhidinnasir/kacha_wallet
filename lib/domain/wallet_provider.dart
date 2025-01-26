import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/transaction_model.dart';
import '../data/models/walletState_model.dart';
import '../data/repositories/mock_api_service.dart';

class WalletNotifier extends StateNotifier<WalletState?> {
  final MockApiService apiService;

  WalletNotifier(this.apiService) : super(null);

  bool isTransactionInProgress = false; // Track transaction state

  Future<void> loadWalletData() async {
    final data = await apiService.fetchWalletData();

    // Sort transactions by date in descending order
    final transactions = (data['transactions'] as List)
        .map((tx) => Transaction.fromJson(tx))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    state = WalletState(
      balance: data['balance'],
      transactions: transactions,
    );
  }

  Future<void> sendMoney(
    String recipient,
    double amount, {
    required String currency,
    required String bank,
    required String accountNumber,
  }) async {
    isTransactionInProgress = true; // Set loading state
    state = state; // Notify listeners

    try {
      final success = await apiService.sendMoney(recipient, amount);
      if (success) {
        // Add the new transaction to the state
        final newTransaction = Transaction(
          id: "T${state!.transactions.length + 1}",
          amount: amount,
          recipient: recipient,
          date: DateTime.now(),
        );

        state = WalletState(
          balance: state!.balance - amount,
          transactions: [...state!.transactions, newTransaction],
        );
      }
    } catch (e) {
      // Handle errors (e.g., logging or displaying a message)
    } finally {
      isTransactionInProgress = false; // Reset loading state
      state = state; // Notify listeners
    }
  }
}

final walletProvider = StateNotifierProvider<WalletNotifier, WalletState?>(
  (ref) => WalletNotifier(MockApiService()),
);
