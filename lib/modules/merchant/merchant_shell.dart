import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/modules/merchant/merchant_dashboard_screen.dart';
import 'package:delivery_partner_app/modules/merchant/order_queue_screen.dart';
import 'package:delivery_partner_app/modules/merchant/menu_management_screen.dart';
import 'package:delivery_partner_app/modules/merchant/merchant_reports_screen.dart';

class MerchantController extends GetxController {
  final currentIndex = 0.obs;
}

class MerchantShell extends StatelessWidget {
  const MerchantShell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MerchantController());
    final screens = [
      const MerchantDashboardScreen(),
      const OrderQueueScreen(),
      const MenuManagementScreen(),
      const MerchantReportsScreen(),
    ];

    return Obx(() => Scaffold(
      body: IndexedStack(
        index: controller.currentIndex.value,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, -4))],
        ),
        child: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (i) => controller.currentIndex.value = i,
          selectedItemColor: AppColors.merchantColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu_rounded), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), label: 'Reports'),
          ],
        ),
      ),
    ));
  }
}
