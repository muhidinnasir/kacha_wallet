import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const ActionButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Card(
          elevation: 0,
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: theme.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
