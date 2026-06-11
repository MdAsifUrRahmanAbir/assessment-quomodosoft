import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/routes/app_routes.dart';
import '../../widgets/app_bottom_nav_bar.dart';

/// Screen 02 – Dashboard (Home)
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentNavIndex = 0;

  void _onNavTap(int index) {
    if (index == 1) {
      Navigator.pushReplacementNamed(context, AppRoutes.services);
    } else {
      setState(() => _currentNavIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Purple header section ──────────────────────────
              _DashboardHeader(),
              // ── Stats cards ───────────────────────────────────
              _StatsSection(),
              // ── Recent transactions ───────────────────────────
              _TransactionsSection(),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Header with gradient background
// ─────────────────────────────────────────────────────────────
class _DashboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.headerStart, AppColors.headerEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppSizes.paddingXL),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingL, AppSizes.paddingM, AppSizes.paddingL, AppSizes.paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: currency + avatar ───────────────────────
          Row(
            children: [
              _HeaderPill(
                child: Row(
                  children: [
                    const Icon(Icons.attach_money_rounded,
                        color: AppColors.textWhite, size: 16),
                    Text(
                      'USD',
                      style: GoogleFonts.poppins(
                        color: AppColors.textWhite,
                        fontSize: AppSizes.fontS,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textWhite, size: 16),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.paddingS),
              _HeaderPill(
                child: Row(
                  children: [
                    const Icon(Icons.language_rounded,
                        color: AppColors.textWhite, size: 16),
                    Text(
                      ' Eng',
                      style: GoogleFonts.poppins(
                        color: AppColors.textWhite,
                        fontSize: AppSizes.fontS,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textWhite, size: 16),
                  ],
                ),
              ),
              const Spacer(),
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.textWhite, width: 2),
                  color: AppColors.primaryLight,
                ),
                child: const Icon(Icons.person, color: AppColors.textWhite),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.paddingL),

          // ── Balance row ──────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Balance',
                    style: GoogleFonts.poppins(
                      color: AppColors.textWhite.withValues(alpha: 0.8),
                      fontSize: AppSizes.fontS,
                    ),
                  ),
                  Text(
                    '\$947.00',
                    style: GoogleFonts.poppins(
                      color: AppColors.textWhite,
                      fontSize: AppSizes.fontDisplay,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Withdraw button
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingL, vertical: AppSizes.paddingS + 2),
                decoration: BoxDecoration(
                  color: AppColors.textWhite,
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
                child: Text(
                  'Withdraw',
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: AppSizes.fontM,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderPill extends StatelessWidget {
  const _HeaderPill({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────
// 2×3 Stats grid
// ─────────────────────────────────────────────────────────────
class _StatsSection extends StatelessWidget {
  final List<_StatItem> _stats = const [
    _StatItem(icon: Icons.shopping_bag_outlined, value: '12', label: 'Active Order', color: Color(0xFF7B3FFF)),
    _StatItem(icon: Icons.access_time_rounded, value: '04', label: 'Pending Order', color: Color(0xFFFF6B35)),
    _StatItem(icon: Icons.check_circle_outline_rounded, value: '450', label: 'Complete Order', color: Color(0xFF22C55E)),
    _StatItem(icon: Icons.list_alt_rounded, value: '14', label: 'Total Services', color: Color(0xFF3B82F6)),
    _StatItem(icon: Icons.account_balance_wallet_outlined, value: '\$320', label: 'Today Earning', color: Color(0xFFF59E0B)),
    _StatItem(icon: Icons.trending_up_rounded, value: '\$50K', label: 'Total Earning', color: Color(0xFF8B5CF6)),
  ];

  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSizes.paddingM,
          crossAxisSpacing: AppSizes.paddingM,
          childAspectRatio: 2.0,
        ),
        itemCount: _stats.length,
        itemBuilder: (context, i) => _StatCard(item: _stats[i]),
      ),
    );
  }
}

class _StatItem {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String value;
  final String label;
  final Color color;
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.item});
  final _StatItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
            ),
            child: Icon(item.icon, color: item.color, size: AppSizes.iconM),
          ),
          const SizedBox(width: AppSizes.paddingS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.value,
                  style: GoogleFonts.poppins(
                    fontSize: AppSizes.fontXL,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                    height: 1,
                  ),
                ),
                Text(
                  item.label,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: AppColors.textMedium,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Recent Transactions section
// ─────────────────────────────────────────────────────────────
class _TransactionsSection extends StatelessWidget {
  final List<_TxItem> _transactions = const [
    _TxItem(
      type: 'Withdraw',
      icon: Icons.arrow_upward_rounded,
      iconColor: Color(0xFFFF6B35),
      iconBg: Color(0xFFFFF0EB),
      time: '3:02 PM',
      date: 'Sep 21, 2023',
      amount: '-\$1200.00',
      isNegative: true,
    ),
    _TxItem(
      type: 'Withdraw',
      icon: Icons.arrow_upward_rounded,
      iconColor: Color(0xFFFF6B35),
      iconBg: Color(0xFFFFF0EB),
      time: '3:02 PM',
      date: 'Sep 21, 2023',
      amount: '+\$150.00',
      isNegative: false,
    ),
    _TxItem(
      type: 'PayPal Payment',
      icon: Icons.paypal_rounded,
      iconColor: Color(0xFF003087),
      iconBg: Color(0xFFE8F0FE),
      time: '3:02 PM',
      date: 'Sep 21, 2023',
      amount: '+\$200.00',
      isNegative: false,
    ),
  ];

  const _TransactionsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
      child: Column(
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: GoogleFonts.poppins(
                  fontSize: AppSizes.fontL,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View all',
                  style: GoogleFonts.poppins(
                    fontSize: AppSizes.fontM,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingM),
          // Transaction list
          ...(_transactions.map((tx) => _TransactionTile(item: tx))),
        ],
      ),
    );
  }
}

class _TxItem {
  const _TxItem({
    required this.type,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.time,
    required this.date,
    required this.amount,
    required this.isNegative,
  });
  final String type;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String time;
  final String date;
  final String amount;
  final bool isNegative;
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.item});
  final _TxItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingM,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: item.iconBg,
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
            child: Icon(item.icon, color: item.iconColor, size: AppSizes.iconM),
          ),
          const SizedBox(width: AppSizes.paddingM),
          // Label + time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.type,
                  style: GoogleFonts.poppins(
                    fontSize: AppSizes.fontM,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  '${item.time} • ${item.date}',
                  style: GoogleFonts.poppins(
                    fontSize: AppSizes.fontXS,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          // Amount
          Text(
            item.amount,
            style: GoogleFonts.poppins(
              fontSize: AppSizes.fontM,
              fontWeight: FontWeight.w700,
              color: item.isNegative ? AppColors.primary : AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}
