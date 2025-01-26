import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'core/util/navigator_service.dart';
import 'domain/theme_provider.dart';
import 'presentation/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: RemittanceApp()));
}

class RemittanceApp extends ConsumerWidget {
  const RemittanceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Kacha Wallet',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme, // Custom Light Theme
      darkTheme: AppThemes.darkTheme, // Custom Dark Theme
      themeMode: themeMode, // Dynamic theme switching
      navigatorKey: NavigatorService.navigatorKey,
      initialRoute: AppRoutes.authScreen,
      routes: AppRoutes.routes,
    );
  }
}
