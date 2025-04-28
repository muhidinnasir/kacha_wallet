import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'core/util/navigator_service.dart';
import 'domain/theme_provider.dart';
import 'presentation/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    dotenv.load(fileName: ".env"),
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]).then((_) {});
  runApp(const ProviderScope(child: WanzaExpressApp()));
}

class WanzaExpressApp extends ConsumerWidget {
  const WanzaExpressApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Wanza Express',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme, // Custom Light Theme
      darkTheme: AppThemes.darkTheme, // Custom Dark Theme
      themeMode: themeMode, // Dynamic theme switching
      navigatorKey: NavigatorService.navigatorKey,
      initialRoute: AppRoutes.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}
