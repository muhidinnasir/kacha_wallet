// ignore_for_file: file_names

import 'transaction_model.dart';

class WalletState {
  final double balance;
  final List<Transaction> transactions;

  WalletState({required this.balance, required this.transactions});

  factory WalletState.fromJson(Map<String, dynamic> json) {
    return WalletState(
      balance: json['balance'],
      transactions: (json['transactions'] as List)
          .map((tx) => Transaction.fromJson(tx))
          .toList(),
    );
  }
}
