import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class OrderQueueController extends GetxController {
  final orders = MockData.merchantOrders.map((o) => Map<String, dynamic>.from(o)).toList().obs;

  List<Map<String, dynamic>> getByStatus(String status) =>
      orders.where((o) => o['status'] == status).toList();

  void moveOrder(String orderId, String newStatus) {
    final index = orders.indexWhere((o) => o['id'] == orderId);
    if (index != -1) {
      if (newStatus == 'Dispatched') {
        orders.removeAt(index);
      } else {
        orders[index] = {...orders[index], 'status': newStatus};
      }
      orders.refresh();
    }
  }
}

class OrderQueueScreen extends StatelessWidget {
  const OrderQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderQueueController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Order Queue', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          backgroundColor: AppColors.background,
          bottom: TabBar(
            labelColor: AppColors.merchantColor,
            indicatorColor: AppColors.merchantColor,
            tabs: const [
              Tab(text: 'New'),
              Tab(text: 'Preparing'),
              Tab(text: 'Ready'),
            ],
          ),
        ),
        body: Obx(() => TabBarView(
          children: [
            _buildOrderList(controller.getByStatus('New'), 'Accept', AppColors.info, (id) => controller.moveOrder(id, 'Preparing')),
            _buildOrderList(controller.getByStatus('Preparing'), 'Ready', AppColors.warning, (id) => controller.moveOrder(id, 'Ready')),
            _buildOrderList(controller.getByStatus('Ready'), 'Dispatched', AppColors.success, (id) => controller.moveOrder(id, 'Dispatched')),
          ],
        )),
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, dynamic>> orders, String action, Color color, Function(String) onAction) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_rounded, size: 64, color: AppColors.textHint.withValues(alpha: 0.3)),
            const SizedBox(height: 12),
            Text('No orders here', style: GoogleFonts.poppins(color: AppColors.textHint)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order['id'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                  Text(order['time'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textHint)),
                ],
              ),
              const SizedBox(height: 6),
              Text(order['customerName'] as String, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(
                (order['items'] as List).join(', '),
                style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₹${(order['total'] as double).toInt()}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.merchantColor)),
                  ElevatedButton(
                    onPressed: () => onAction(order['id'] as String),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(action, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
