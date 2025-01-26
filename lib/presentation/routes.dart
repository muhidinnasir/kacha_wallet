import 'package:flutter/material.dart';
import 'package:remittance_app/presentation/screens/authScreen/auth_screen.dart';

import 'screens/currencyExchangeScreen/exchange_rate_screen.dart';
import 'screens/transferMoneyScreen/transfer_screen.dart';
import 'screens/dashboardScreen/dashboard_screen.dart';

class AppRoutes {
  static const String authScreen = '/authScreen';
  static const String dashboardScreen = '/wallet';
  static const String transfer = '/transfer';
  static const String exchange = '/exchange';

  static Map<String, WidgetBuilder> get routes => {
        authScreen: AuthScreen.builder,
        dashboardScreen: DashboardScreen.builder,
        transfer: TransferScreen.builder,
        exchange: ExchangeRateScreen.builder,
      };
}
