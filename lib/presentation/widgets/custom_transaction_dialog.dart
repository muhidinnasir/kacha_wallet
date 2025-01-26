import 'package:flutter/material.dart';

class CustomTransactionDialog extends StatelessWidget {
  final String title;
  final Map<String, dynamic> transactionDetails;

  const CustomTransactionDialog({
    Key? key,
    required this.title,
    required this.transactionDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Divider(color: theme.primaryColor),
            for (var entry in transactionDetails.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      entry.value.toString(),
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
