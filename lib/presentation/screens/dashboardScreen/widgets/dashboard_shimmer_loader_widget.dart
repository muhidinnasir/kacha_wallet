import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/custome_shimmer.dart';

class DashboardShimmerLoader extends StatelessWidget {
  const DashboardShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        _buildShimmerHeader(),
        const SizedBox(height: 40),
        _buildShimmerBalance(),
        const SizedBox(height: 20),
        _buildShimmerOperations(),
        const SizedBox(height: 20),
        _buildShimmerTransactions(),
      ],
    );
  }

  // Shimmer for the header
  Widget _buildShimmerHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Row(
        children: [
          CustomShimmer(
            height: 40.0,
            width: 40.0,
            borderRadius: BorderRadius.circular(100.0),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShimmer(
                width: 100,
                height: 10,
                borderRadius: BorderRadius.circular(10.0),
              ),
              const SizedBox(height: 10),
              CustomShimmer(
                width: 150,
                height: 10,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Shimmer for the balance
  Widget _buildShimmerBalance() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShimmer(
            width: 150,
            height: 10,
            borderRadius: BorderRadius.circular(10.0),
          ),
          const SizedBox(height: 10),
          CustomShimmer(
            width: 100,
            height: 20,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ],
      ),
    );
  }

  // Shimmer for the balance
  Widget _buildShimmerOperations() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShimmer(
            height: 10.0,
            width: 100.0,
            borderRadius: BorderRadius.circular(10.0),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CustomShimmer(
                    height: 50.0,
                    width: 50.0,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  const SizedBox(height: 10),
                  CustomShimmer(
                    height: 10.0,
                    width: 40.0,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomShimmer(
                    height: 50.0,
                    width: 50.0,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  const SizedBox(height: 10),
                  CustomShimmer(
                    height: 10.0,
                    width: 40.0,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomShimmer(
                    height: 50.0,
                    width: 50.0,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  const SizedBox(height: 10),
                  CustomShimmer(
                    height: 10.0,
                    width: 40,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomShimmer(
                    height: 50.0,
                    width: 50.0,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  const SizedBox(height: 10),
                  CustomShimmer(
                    height: 10.0,
                    width: 40.0,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              CustomShimmer(
                height: 10.0,
                width: 100.0,
                borderRadius: BorderRadius.circular(10.0),
              ),
              const Spacer(),
              CustomShimmer(
                height: 10.0,
                width: 30.0,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Shimmer for transactions
  Widget _buildShimmerTransactions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Show 5 shimmer placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: ListTile(
              title: Container(
                height: 10,
                width: 100,
                color: Colors.grey,
              ),
              subtitle: Container(
                height: 10,
                width: 150,
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
