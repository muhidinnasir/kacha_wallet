import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/walletState_model.dart';
import '../data/repositories/api_service.dart';

class WalletNotifier extends StateNotifier<WalletState?> {
  final ApiService apiService;

  WalletNotifier(this.apiService) : super(null);
}

final walletProvider = StateNotifierProvider<WalletNotifier, WalletState?>(
  (ref) => WalletNotifier(ApiService()),
);
