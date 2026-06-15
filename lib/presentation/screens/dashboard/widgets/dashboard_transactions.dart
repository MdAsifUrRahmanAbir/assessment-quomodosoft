import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_assets.dart';
import 'dashboard_transaction_tile.dart';
import 'dashboard_tx_model.dart';

class DashboardTransactions extends StatelessWidget {
  final List<DashboardTxModel> _transactions = const [
    DashboardTxModel(
      type: 'Withdraw',
      iconPath: AppAssets.withdraw,
      iconColor: Color(0xFFFF6B35),
      iconBg: Color(0xFFFFF0EB),
      time: '3:02 PM',
      date: 'Sep 21, 2023',
      amount: '-\$1200.00',
      isNegative: true,
    ),
    DashboardTxModel(
      type: 'Withdraw',
      iconPath: AppAssets.withdraw,
      iconColor: Color(0xFFFF6B35),
      iconBg: Color(0xFFFFF0EB),
      time: '3:02 PM',
      date: 'Sep 21, 2023',
      amount: '+\$150.00',
      isNegative: false,
    ),
    DashboardTxModel(
      type: 'PayPal Payment',
      iconPath: AppAssets.paypal,
      iconColor: Color(0xFF003087),
      iconBg: Color(0xFFE8F0FE),
      time: '3:02 PM',
      date: 'Sep 21, 2023',
      amount: '+\$200.00',
      isNegative: false,
    ),
  ];

  const DashboardTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View all',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF2563EB),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...(_transactions.map((tx) => Column(
            children: [
              DashboardTransactionTile(item: tx),
              Divider(height: 4, color: Colors.black.withValues(alpha: .1),)
            ],
          ))),
        ],
      ),
    );
  }
}
