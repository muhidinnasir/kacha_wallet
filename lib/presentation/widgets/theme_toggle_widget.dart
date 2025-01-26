import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/theme_provider.dart';

class ThemeToggleWidget extends ConsumerWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return IconButton(
      icon: Icon(
        themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
      ),
      onPressed: () {
        ref.read(themeProvider.notifier).toggleTheme();
      },
      tooltip: "Toggle Theme",
    );
  }
}
