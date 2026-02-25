import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class OrderManagementController extends GetxController {
  final selectedFilter = 'All'.obs;
  final filters = ['All', 'Pending', 'Confirmed', 'Preparing', 'Picked Up', 'Delivered', 'Cancelled'];

  List<Map<String, dynamic>> get filteredOrders {
    if (selectedFilter.value == 'All') return MockData.merchantOrders;
    return MockData.merchantOrders.where((o) => o['status'] == selectedFilter.value).toList();
  }
}

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderManagementController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 56,
            child: Obx(() => ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: controller.filters.length,
              itemBuilder: (context, index) {
                final filter = controller.filters[index];
                final isSelected = controller.selectedFilter.value == filter;
                return GestureDetector(
                  onTap: () => controller.selectedFilter.value = filter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.adminColor : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(filter, style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    )),
                  ),
                );
              },
            )),
          ),
          // Order list
          Expanded(
            child: Obx(() {
              final orders = controller.filteredOrders;
              if (orders.isEmpty) {
                return Center(child: Text('No orders found', style: GoogleFonts.poppins(color: AppColors.textHint)));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.orderDetail, arguments: order),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('#${order['id']}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700)),
                              const Spacer(),
                              StatusChip(label: order['status'] as String, color: statusColor(order['status'] as String)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _infoRow(Icons.person_rounded, 'Customer', order['customer'] as String),
                          const SizedBox(height: 6),
                          _infoRow(Icons.store_rounded, 'Merchant', 'Spice Junction'),
                          const SizedBox(height: 6),
                          _infoRow(Icons.delivery_dining_rounded, 'Rider', 'Amit K.'),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('${order['items']} items', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                              const Spacer(),
                              Text('₹${order['total']}', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.primary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textHint),
        const SizedBox(width: 8),
        Text('$label: ', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
        Text(value, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
