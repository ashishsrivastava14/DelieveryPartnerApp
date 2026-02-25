import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delivery_partner_app/modules/customer/home_screen.dart';
import 'package:delivery_partner_app/modules/customer/search_screen.dart';
import 'package:delivery_partner_app/modules/customer/order_history_screen.dart';
import 'package:delivery_partner_app/modules/customer/profile_screen.dart';

class CustomerController extends GetxController {
  final currentIndex = 0.obs;
}

class CustomerShell extends StatelessWidget {
  const CustomerShell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    final screens = [
      const CustomerHomeScreen(),
      const CustomerSearchScreen(),
      const OrderHistoryScreen(),
      const CustomerProfileScreen(),
    ];

    return Obx(() => Scaffold(
      body: IndexedStack(
        index: controller.currentIndex.value,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, -4)),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (i) => controller.currentIndex.value = i,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    ));
  }
}
