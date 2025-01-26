import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remittance_app/core/util/date_time_extension.dart';
import 'package:remittance_app/core/util/navigator_service.dart';
import 'package:remittance_app/presentation/routes.dart';
import 'package:remittance_app/presentation/widgets/theme_toggle_widget.dart';
import '../../../data/repositories/mock_api_service.dart';
import '../../../domain/wallet_provider.dart';
import '../../widgets/custom_transaction_dialog.dart';
import 'widgets/action_button_widget.dart';
import 'widgets/dashboard_shimmer_loader_widget.dart';

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
      backgroundColor: theme.primaryColor,
      body: RefreshIndicator(
        onRefresh: loadWalletData,
        child: isWalletDataLoading
            ? const DashboardShimmerLoader() // Show shimmer while loading
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome Back",
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Text(
                                  fullName ?? "Loading...",
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const ThemeToggleWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Available Balance Widget
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Balance",
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "\$${walletState?.balance.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Recent transactions List Widget
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: theme.canvasColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Text(
                            "Operations",
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ActionButton(
                                onPressed: () => NavigatorService.pushNamed(
                                    AppRoutes.transfer),
                                icon: Icons.send,
                                label: "Send Money",
                              ),
                              ActionButton(
                                onPressed: () {},
                                icon: Icons.account_balance_wallet_outlined,
                                label: "Withdraw",
                              ),
                              ActionButton(
                                onPressed: () {},
                                icon: Icons.wallet_rounded,
                                label: "Top Up",
                              ),
                              ActionButton(
                                onPressed: () => NavigatorService.pushNamed(
                                    AppRoutes.exchange),
                                icon: Icons.currency_exchange_rounded,
                                label: "Exchange Currency",
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              Text(
                                "Recent Transactions",
                                style: theme.textTheme.bodyMedium,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Text('See All'),
                              ),
                            ],
                          ),
                          walletState == null ||
                                  walletState.transactions.isEmpty
                              ? const Center(
                                  child: Text("No transactions yet."),
                                )
                              : Expanded(
                                  child: ListView.separated(
                                    itemCount: walletState.transactions.length,
                                    separatorBuilder: (context, index) =>
                                        Divider(color: theme.primaryColor),
                                    itemBuilder: (context, index) {
                                      // Sort the transactions by date in descending order
                                      final sortedTransactions = walletState
                                          .transactions
                                        ..sort(
                                            (a, b) => b.date.compareTo(a.date));

                                      final transaction =
                                          sortedTransactions[index];

                                      return ListTile(
                                        contentPadding: const EdgeInsets.all(2),
                                        leading: const CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.black,
                                          child: Icon(Icons.person,
                                              color: Colors.white),
                                        ),
                                        title: Text(
                                          "-\$${transaction.amount}",
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                        subtitle: Text(
                                          "Recipient: ${transaction.recipient}\nDate: ${transaction.date.format()}",
                                          style: theme.textTheme.bodySmall,
                                        ),
                                        trailing: Text(
                                          transaction.id,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CustomTransactionDialog(
                                              title: "Transaction Details",
                                              transactionDetails: {
                                                "Transaction ID":
                                                    transaction.id,
                                                "Amount":
                                                    "-\$${transaction.amount}",
                                                "Recipient":
                                                    transaction.recipient,
                                                "Date":
                                                    transaction.date.format(),
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
