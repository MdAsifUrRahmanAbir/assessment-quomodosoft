import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/routes/app_routes.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/service_card.dart';

/// Screen 03 – Services Listing
class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  int _currentNavIndex = 1;

  // Demo data mirroring the Figma screenshots
  final List<_ServiceData> _services = [
    _ServiceData(
      id: '1',
      title: 'Confident experience smart recording video vlog',
      category: 'Vloggers',
      price: 188,
      rating: 4.5,
      reviewCount: 6,
      imageUrl:
          'https://images.unsplash.com/photo-1598387993282-3e5a8e4d8d4a?w=800',
      date: '21 Sep, 2023',
      isActive: true,
    ),
    _ServiceData(
      id: '2',
      title: 'S gy professional gym training sessions and fitness',
      category: 'Vloggers',
      price: 188,
      rating: 4.0,
      reviewCount: 12,
      imageUrl:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
      date: '21 Sep, 2023',
      isActive: true,
    ),
  ];

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else {
      setState(() => _currentNavIndex = index);
    }
  }

  void _onDeleteService(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
        ),
        title: Text(
          'Delete Service',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Are you sure you want to delete this service?',
          style: GoogleFonts.poppins(color: AppColors.textMedium),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: AppColors.textMedium),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _services.removeWhere((s) => s.id == id));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Service deleted successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(color: AppColors.textWhite),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.dashboard),
          child: Container(
            margin: const EdgeInsets.only(left: AppSizes.paddingM),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.inputBg,
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.textDark,
                size: AppSizes.iconS,
              ),
            ),
          ),
        ),
        title: Text(
          'Services',
          style: GoogleFonts.poppins(
            color: AppColors.textDark,
            fontSize: AppSizes.fontXL,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Add New Service button ─────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSizes.paddingM, AppSizes.paddingM, AppSizes.paddingM, 0),
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.createService),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.paddingM),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius:
                        BorderRadius.circular(AppSizes.radiusM),
                    border: Border.all(
                      color: AppColors.border,
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.textMedium),
                          borderRadius:
                              BorderRadius.circular(AppSizes.paddingXS),
                        ),
                        child: const Icon(Icons.add,
                            color: AppColors.textMedium, size: 16),
                      ),
                      const SizedBox(width: AppSizes.paddingS),
                      Text(
                        'Add New Service',
                        style: GoogleFonts.poppins(
                          fontSize: AppSizes.fontM,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.paddingM),

            // ── Service cards list ─────────────────────────────
            Expanded(
              child: _services.isEmpty
                  ? _EmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                          AppSizes.paddingM, 0, AppSizes.paddingM, 120),
                      itemCount: _services.length,
                      itemBuilder: (context, i) {
                        final s = _services[i];
                        return ServiceCard(
                          title: s.title,
                          category: s.category,
                          price: s.price,
                          rating: s.rating,
                          reviewCount: s.reviewCount,
                          imageUrl: s.imageUrl,
                          date: s.date,
                          isActive: s.isActive,
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.serviceDetails,
                              arguments: s.id),
                          onEdit: () => Navigator.pushNamed(
                              context, AppRoutes.updateService,
                              arguments: s.id),
                          onDelete: () => _onDeleteService(s.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.grid_off_rounded,
              size: 64, color: AppColors.textLight),
          const SizedBox(height: AppSizes.paddingM),
          Text(
            'No services yet',
            style: GoogleFonts.poppins(
              fontSize: AppSizes.fontXL,
              fontWeight: FontWeight.w600,
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: AppSizes.paddingS),
          Text(
            'Tap "+ Add New Service" to get started',
            style: GoogleFonts.poppins(
              fontSize: AppSizes.fontM,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceData {
  const _ServiceData({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.date,
    required this.isActive,
  });

  final String id;
  final String title;
  final String category;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String date;
  final bool isActive;
}
