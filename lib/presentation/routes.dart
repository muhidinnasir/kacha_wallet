import 'package:flutter/material.dart';
import 'package:wanza_express/presentation/screens/authScreen/auth_screen.dart';
import 'package:wanza_express/presentation/screens/shipmentDetailFormScreen/shipment_detail_form_screen.dart';

import 'screens/currencyExchangeScreen/exchange_rate_screen.dart';
import 'screens/shipmentDirectionScreen/shipment_screen.dart';
import 'screens/splashScreen/splash_screen.dart';
import 'screens/transferMoneyScreen/transfer_screen.dart';
import 'screens/dashboardScreen/dashboard_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String authScreen = '/authScreen';
  static const String dashboardScreen = '/wallet';
  static const String transfer = '/transfer';
  static const String exchange = '/exchange';
  static const String createshipmentScreen = '/shipmentScreen';
  static const String shipmentDetailFormScreen = '/shipmentDetailFormScreen';

  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        authScreen: AuthScreen.builder,
        dashboardScreen: DashboardScreen.builder,
        transfer: TransferScreen.builder,
        exchange: ExchangeRateScreen.builder,
        createshipmentScreen: ShipmentScreen.builder,
        shipmentDetailFormScreen: ShipmentDetailFormScreen.builder,
      };
}
