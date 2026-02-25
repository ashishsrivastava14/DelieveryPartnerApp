import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';

class MenuManagementScreen extends StatelessWidget {
  const MenuManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCat = 'Burgers'.obs;
    final menuItems = MockData.menuItems.map((e) => Map<String, dynamic>.from(e)).toList().obs;
    final categories = ['Burgers', 'Pizza', 'Drinks'];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Menu Management', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.background,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.merchantColor,
        onPressed: () => _showAddItemDialog(context, menuItems),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text('Add Item', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: Column(
        children: [
          // Category tabs
          Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: categories.map((cat) {
                final isSelected = selectedCat.value == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) => selectedCat.value = cat,
                    selectedColor: AppColors.merchantColor,
                    labelStyle: GoogleFonts.poppins(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    showCheckmark: false,
                  ),
                );
              }).toList(),
            ),
          )),
          Expanded(
            child: Obx(() {
              final items = menuItems.where((e) => e['category'] == selectedCat.value).toList();
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final globalIndex = menuItems.indexOf(item);
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.fastfood_rounded, color: AppColors.merchantColor.withValues(alpha: 0.3)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                              Text('₹${(item['price'] as double).toInt()}', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.merchantColor, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Switch(
                          value: item['isAvailable'] as bool,
                          onChanged: (_) {
                            menuItems[globalIndex] = {...item, 'isAvailable': !(item['isAvailable'] as bool)};
                          },
                          activeThumbColor: AppColors.success,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_outlined, color: AppColors.textHint, size: 20),
                        ),
                      ],
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

  void _showAddItemDialog(BuildContext context, RxList<Map<String, dynamic>> menuItems) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final catCtrl = 'Burgers'.obs;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Add New Item', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(hintText: 'Item Name', prefixIcon: Icon(Icons.fastfood_outlined)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Price (₹)', prefixIcon: Icon(Icons.currency_rupee_rounded)),
            ),
            const SizedBox(height: 12),
            Obx(() => DropdownButtonFormField<String>(
              initialValue: catCtrl.value,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.category_outlined)),
              items: ['Burgers', 'Pizza', 'Drinks'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => catCtrl.value = val!,
            )),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.textSecondary))),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty && priceCtrl.text.isNotEmpty) {
                menuItems.add({
                  'id': 'new_${menuItems.length}',
                  'name': nameCtrl.text,
                  'price': double.tryParse(priceCtrl.text) ?? 0,
                  'category': catCtrl.value,
                  'description': 'New item',
                  'isVeg': true,
                  'isAvailable': true,
                  'orderCount': 0,
                  'image': '',
                });
                Get.back();
                Get.snackbar('Added!', '${nameCtrl.text} added to menu', backgroundColor: AppColors.success.withValues(alpha: 0.1), colorText: AppColors.success, snackPosition: SnackPosition.BOTTOM);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.merchantColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: Text('Add Item', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
