import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = MockData.adminStats;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                KpiCard(title: 'Orders Today', value: '${stats['totalOrdersToday']}', icon: Icons.shopping_cart_rounded, color: AppColors.primary),
                KpiCard(title: 'Revenue', value: '₹${((stats['totalRevenue'] as double) / 1000).toStringAsFixed(1)}K', icon: Icons.currency_rupee_rounded, color: AppColors.success),
                KpiCard(title: 'Active Riders', value: '${stats['activeRiders']}', icon: Icons.delivery_dining_rounded, color: AppColors.riderColor),
                KpiCard(title: 'Active Merchants', value: '${stats['activeMerchants']}', icon: Icons.storefront_rounded, color: AppColors.merchantColor),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Orders
            Text('Recent Orders', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text('Order ID', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary))),
                        Expanded(flex: 2, child: Text('Customer', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary))),
                        Expanded(flex: 1, child: Text('Amount', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary))),
                        Expanded(flex: 1, child: Text('Status', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary))),
                      ],
                    ),
                  ),
                  ...MockData.orders.take(5).map((order) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppColors.divider.withValues(alpha: 0.5))),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(order['id'] as String, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500))),
                        Expanded(flex: 2, child: Text(order['customerName'] as String, style: GoogleFonts.poppins(fontSize: 12))),
                        Expanded(flex: 1, child: Text('₹${(order['total'] as double).toInt()}', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600))),
                        Expanded(flex: 1, child: StatusChip(label: order['status'] as String, color: statusColor(order['status'] as String))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Text('Quick Actions', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: [
                _actionCard('Add Zone', Icons.add_location_alt_rounded, AppColors.primary, () {
                  final adminCtrl = Get.find<dynamic>();
                  if (adminCtrl is AdminDashboardScreen) return;
                  // Navigate to zone management
                }),
                const SizedBox(width: 10),
                _actionCard('Create Promo', Icons.local_offer_rounded, AppColors.accent, () {}),
                const SizedBox(width: 10),
                _actionCard('View Reports', Icons.analytics_rounded, AppColors.success, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(title, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: color), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
