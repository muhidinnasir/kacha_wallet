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
    this.isExpanded = false,
    this.validator,
  }) : super(key: key);

  final List<DropdownMenuItem<T>> items;
  final String? Function(T?)? validator;
  final T? value;
  final ValueChanged<T?> onChanged;
  final Widget? hint;
  final InputDecoration? decoration;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final String? label;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: DropdownButtonFormField<T>(
        value: items.any((item) => item.value == value)
            ? value
            : null, // Ensure value exists in items
        items: items,
        onChanged: (value) {
          onChanged(value); // Call the provided callback
          Form.of(context).validate(); // Revalidate the form
        },
        isExpanded: isExpanded,
        hint: hint,
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Colors.black,
          size: 20,
        ),
        validator: validator,
        decoration: decoration ??
            InputDecoration(
              filled: true,
              fillColor: const Color(0xffE7E7E7),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
      ),
    );
  }
}
