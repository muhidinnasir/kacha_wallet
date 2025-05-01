import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remittance_app/core/util/date_time_extension.dart';
import 'package:remittance_app/core/util/navigator_service.dart';
import 'package:remittance_app/presentation/routes.dart';
import 'package:remittance_app/presentation/widgets/custom_image_view.dart';
import 'package:remittance_app/presentation/widgets/theme_toggle_widget.dart';
import '../../../core/image_constants.dart';
import '../../../data/repositories/mock_api_service.dart';
import '../../../domain/wallet_provider.dart';
import '../../widgets/custom_transaction_dialog.dart';
import 'widgets/action_button_widget.dart';
import 'widgets/dashboard_shimmer_loader_widget.dart';
import 'widgets/order_widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  static Widget builder(BuildContext context) => const DashboardScreen();

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool isWalletDataLoading = false;
  String? fullName;

  @override
  void initState() {
    super.initState();

    // Automatically load wallet data and fetch user's full name
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadWalletData();
      await loadUserFullName();
    });
  }

  Future<void> loadWalletData() async {
    setState(() {
      isWalletDataLoading = true;
    });
    await ref.read(walletProvider.notifier).loadWalletData();
    setState(() {
      isWalletDataLoading = false;
    });
  }

  Future<void> loadUserFullName() async {
    final apiService = MockApiService();
    fullName = await apiService.getFullName();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: loadWalletData,
        child: isWalletDataLoading
            ? const DashboardShimmerLoader() // Show shimmer while loading
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Header section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Profile Picture
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey,
                                child: CustomImageView(
                                  imagePath: ImageConstant.tracksloadIogo,
                                  fit: BoxFit.cover,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "👋  Hello, Abebe!",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        // const ThemeToggleWidget(),
                        // notification icon
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {
                            // Handle notification icon tap
                          },
                        ),
                      ],
                    ),
                  ),
                  // Driver Order assignments section
                  Text(
                    "Assignments",
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  // Order assignment list
                  Expanded(
                    child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: OrderWidget(),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
