class Transaction {
  final String id;
  final double amount;
  final String recipient;
  final DateTime date;

  Transaction({
    required this.id,
    required this.amount,
    required this.recipient,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount'],
      recipient: json['recipient'],
      date: DateTime.parse(json['date']),
    );
  }
}
