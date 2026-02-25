import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';

class ZoneManagementController extends GetxController {
  final zones = MockData.zones.map((z) => Map<String, dynamic>.from(z)).toList().obs;

  void addZone(String name, String city, double radius) {
    zones.add({
      'name': name,
      'city': city,
      'radius': radius,
      'active': true,
      'riders': 0,
      'merchants': 0,
    });
  }

  void toggleActive(int index) {
    zones[index]['active'] = !(zones[index]['active'] as bool);
    zones.refresh();
  }

  void deleteZone(int index) {
    zones.removeAt(index);
  }
}

class ZoneManagementScreen extends StatelessWidget {
  const ZoneManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ZoneManagementController());

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddZoneDialog(context, controller),
        backgroundColor: AppColors.adminColor,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text('Add Zone', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: Obx(() => ListView.separated(
        padding: const EdgeInsets.all(20),
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemCount: controller.zones.length,
        itemBuilder: (context, index) {
          final zone = controller.zones[index];
          final isActive = zone['active'] as bool;

          return Dismissible(
            key: Key('zone_$index'),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.delete_rounded, color: Colors.white),
            ),
            onDismissed: (_) {
              controller.deleteZone(index);
              Get.snackbar('Deleted', '${zone['name']} zone removed', snackPosition: SnackPosition.BOTTOM);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isActive ? Colors.green.withValues(alpha: 0.3) : Colors.red.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.adminColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.map_rounded, color: AppColors.adminColor, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(zone['name'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                            Text(zone['city'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      Switch(
                        value: isActive,
                        onChanged: (_) => controller.toggleActive(index),
                        activeThumbColor: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _chip(Icons.radar_rounded, '${zone['radius']} km'),
                      const SizedBox(width: 10),
                      _chip(Icons.delivery_dining_rounded, '${zone['riders']} Riders'),
                      const SizedBox(width: 10),
                      _chip(Icons.store_rounded, '${zone['merchants']} Merchants'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  void _showAddZoneDialog(BuildContext context, ZoneManagementController controller) {
    final nameC = TextEditingController();
    final cityC = TextEditingController();
    final radiusC = TextEditingController(text: '5');

    Get.dialog(AlertDialog(
      title: Text('Add Zone', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameC, decoration: const InputDecoration(labelText: 'Zone Name')),
          const SizedBox(height: 10),
          TextField(controller: cityC, decoration: const InputDecoration(labelText: 'City')),
          const SizedBox(height: 10),
          TextField(controller: radiusC, decoration: const InputDecoration(labelText: 'Radius (km)'), keyboardType: TextInputType.number),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (nameC.text.isNotEmpty && cityC.text.isNotEmpty) {
              controller.addZone(nameC.text, cityC.text, double.tryParse(radiusC.text) ?? 5);
              Get.back();
              Get.snackbar('Zone Added', '${nameC.text} zone created', snackPosition: SnackPosition.BOTTOM);
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.adminColor),
          child: Text('Add', style: GoogleFonts.poppins(color: Colors.white)),
        ),
      ],
    ));
  }
}
