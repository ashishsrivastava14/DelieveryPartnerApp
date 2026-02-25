import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/modules/rider/dashboard_screen.dart';
import 'package:delivery_partner_app/modules/rider/delivery_history_screen.dart';
import 'package:delivery_partner_app/modules/rider/earnings_screen.dart';
import 'package:delivery_partner_app/modules/rider/rider_profile_screen.dart';

class RiderController extends GetxController {
  final currentIndex = 0.obs;
}

class RiderShell extends StatelessWidget {
  const RiderShell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RiderController());
    final screens = [
      const RiderDashboardScreen(),
      const DeliveryHistoryScreen(),
      const EarningsScreen(),
      const RiderProfileScreen(),
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
          selectedItemColor: AppColors.riderColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'Deliveries'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded), label: 'Earnings'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    ));
  }
}
