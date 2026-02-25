import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';
import 'package:delivery_partner_app/modules/admin/admin_dashboard_screen.dart';
import 'package:delivery_partner_app/modules/admin/user_management_screen.dart';
import 'package:delivery_partner_app/modules/admin/order_management_screen.dart';
import 'package:delivery_partner_app/modules/admin/zone_management_screen.dart';
import 'package:delivery_partner_app/modules/admin/payout_management_screen.dart';
import 'package:delivery_partner_app/modules/admin/promo_management_screen.dart';
import 'package:delivery_partner_app/modules/admin/analytics_screen.dart';
import 'package:delivery_partner_app/modules/admin/app_settings_screen.dart';
import 'package:delivery_partner_app/modules/admin/support_tickets_screen.dart';

class AdminController extends GetxController {
  final currentScreen = 0.obs;
}

class AdminShell extends StatelessWidget {
  const AdminShell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final screens = [
      const AdminDashboardScreen(),
      const UserManagementScreen(),
      const OrderManagementScreen(),
      const ZoneManagementScreen(),
      const PayoutManagementScreen(),
      const PromoManagementScreen(),
      const AnalyticsScreen(),
      const AppSettingsScreen(),
      const SupportTicketsScreen(),
    ];

    final menuItems = [
      {'icon': Icons.dashboard_rounded, 'title': 'Dashboard'},
      {'icon': Icons.people_rounded, 'title': 'User Management'},
      {'icon': Icons.receipt_long_rounded, 'title': 'Orders'},
      {'icon': Icons.map_rounded, 'title': 'Zone Management'},
      {'icon': Icons.payments_rounded, 'title': 'Payouts'},
      {'icon': Icons.local_offer_rounded, 'title': 'Promo Codes'},
      {'icon': Icons.analytics_rounded, 'title': 'Analytics'},
      {'icon': Icons.settings_rounded, 'title': 'Settings'},
      {'icon': Icons.support_agent_rounded, 'title': 'Support Tickets'},
    ];

    return Obx(() => Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(menuItems[controller.currentScreen.value]['title'] as String, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: _buildDrawer(controller, menuItems, scaffoldKey),
      body: IndexedStack(
        index: controller.currentScreen.value,
        children: screens,
      ),
    ));
  }

  Widget _buildDrawer(AdminController controller, List<Map<String, dynamic>> menuItems, GlobalKey<ScaffoldState> scaffoldKey) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              decoration: const BoxDecoration(gradient: AppColors.darkGradient),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.admin_panel_settings_rounded, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 12),
                  Text('Admin Panel', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text('DeliverEase Platform', style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
                ],
              ),
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final isSelected = controller.currentScreen.value == index;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.adminColor.withValues(alpha: 0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(item['icon'] as IconData, color: isSelected ? AppColors.adminColor : AppColors.textSecondary, size: 22),
                      title: Text(item['title'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, color: isSelected ? AppColors.adminColor : AppColors.textPrimary)),
                      onTap: () {
                        controller.currentScreen.value = index;
                        scaffoldKey.currentState?.closeDrawer();
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      dense: true,
                    ),
                  );
                },
              )),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: AppColors.error),
              title: Text('Logout', style: GoogleFonts.poppins(color: AppColors.error, fontWeight: FontWeight.w500)),
              onTap: () => Get.offAllNamed(AppRoutes.roleSelection),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
