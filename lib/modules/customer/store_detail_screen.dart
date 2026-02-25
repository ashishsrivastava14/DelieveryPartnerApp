import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';

class StoreDetailController extends GetxController {
  final cartItems = <String, int>{}.obs;

  void addItem(String id) {
    cartItems[id] = (cartItems[id] ?? 0) + 1;
  }

  void removeItem(String id) {
    if (cartItems.containsKey(id) && cartItems[id]! > 0) {
      cartItems[id] = cartItems[id]! - 1;
      if (cartItems[id] == 0) cartItems.remove(id);
    }
  }

  int get totalItems => cartItems.values.fold(0, (a, b) => a + b);
}

class StoreDetailScreen extends StatelessWidget {
  const StoreDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Get.arguments as Map<String, dynamic>? ?? MockData.stores[0];
    final controller = Get.put(StoreDetailController());
    final menuCategories = ['Burgers', 'Pizza', 'Drinks'];
    final selectedCat = 'Burgers'.obs;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
              ),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: Center(
                  child: Icon(Icons.storefront_rounded, size: 60, color: Colors.white.withValues(alpha: 0.3)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(store['name'] as String, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 16, color: AppColors.secondary),
                            const SizedBox(width: 4),
                            Text('${store['rating']}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('${store['category']} • ${store['distance']} • ${store['eta']}', style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Text('${store['timing']}', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textHint)),
                  const SizedBox(height: 16),
                  const Divider(),
                ],
              ),
            ),
          ),
          // Category tabs
          SliverPersistentHeader(
            pinned: true,
            delegate: _CategoryHeaderDelegate(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(() => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: menuCategories.map((cat) {
                      final isSelected = selectedCat.value == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          onSelected: (_) => selectedCat.value = cat,
                          selectedColor: AppColors.primary,
                          labelStyle: GoogleFonts.poppins(
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          backgroundColor: AppColors.surfaceVariant,
                          showCheckmark: false,
                        ),
                      );
                    }).toList(),
                  ),
                )),
              ),
            ),
          ),
          // Menu items
          Obx(() {
            final items = MockData.menuItems.where((e) => e['category'] == selectedCat.value).toList();
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = items[index];
                  final id = item['id'] as String;
                  final qty = controller.cartItems[id] ?? 0;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Center(child: Icon(Icons.fastfood_rounded, color: AppColors.primary.withValues(alpha: 0.3))),
                              if (item['isVeg'] == true)
                                Positioned(
                                  top: 4,
                                  left: 4,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.success, width: 1.5),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(child: Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(2)))),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 3),
                              Text(item['description'] as String, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary), maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 6),
                              Text('₹${(item['price'] as double).toInt()}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        item['isAvailable'] == true
                            ? qty == 0
                                ? ElevatedButton(
                                    onPressed: () => controller.addItem(id),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    child: Text('ADD', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () => controller.removeItem(id),
                                          icon: const Icon(Icons.remove, color: Colors.white, size: 18),
                                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                          padding: EdgeInsets.zero,
                                        ),
                                        Text('$qty', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
                                        IconButton(
                                          onPressed: () => controller.addItem(id),
                                          icon: const Icon(Icons.add, color: Colors.white, size: 18),
                                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                          padding: EdgeInsets.zero,
                                        ),
                                      ],
                                    ),
                                  )
                            : Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.error.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('Unavailable', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.error, fontWeight: FontWeight.w500)),
                              ),
                      ],
                    ),
                  );
                },
                childCount: items.length,
              ),
            );
          }),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: Obx(() {
        if (controller.totalItems == 0) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, -4))],
          ),
          child: SafeArea(
            child: GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.cart),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${controller.totalItems} items in cart', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        Text('View Cart', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _CategoryHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;
  @override
  double get maxExtent => 56;
  @override
  double get minExtent => 56;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
