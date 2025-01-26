// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  const CustomDropdownFormField({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
    this.decoration,
    this.borderRadius = 8.0,
    this.contentPadding,
    this.label,
  }) : super(key: key);

  /// List of items to display in the dropdown
  final List<DropdownMenuItem<T>> items;

  /// Current selected value
  final T? value;

  /// Callback for when the value changes
  final ValueChanged<T?> onChanged;

  /// Hint widget to display when no value is selected
  final Widget? hint;

  /// Decoration for the dropdown (InputDecoration)
  final InputDecoration? decoration;

  /// Border radius for the dropdown field
  final double borderRadius;

  /// Content padding for the dropdown
  final EdgeInsetsGeometry? contentPadding;

  final String? label;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      hint: hint,
      decoration: decoration ??
          InputDecoration(
            labelText: label,
            isDense: true,
            contentPadding: contentPadding ?? const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
          ),
    );
  }
}
