import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.person_rounded, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Good afternoon! 👋', style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
                              Text('Rahul Sharma', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Search bar
                    GestureDetector(
                      onTap: () {
                        final customerCtrl = Get.find<dynamic>();
                        customerCtrl.currentIndex.value = 1;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search_rounded, color: AppColors.textHint),
                            const SizedBox(width: 10),
                            Text('Search for stores, food, groceries...', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textHint)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Categories', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemCount: MockData.categories.length,
                  itemBuilder: (context, index) {
                    final cat = MockData.categories[index];
                    return Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(cat['color'] as int).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(cat['icon'] as String, style: const TextStyle(fontSize: 28)),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(cat['name'] as String, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),

              // Active Order Banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.orderTracking),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppColors.secondaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: AppColors.secondary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.delivery_dining_rounded, color: Colors.white, size: 26),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Active Order', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                              Text('Pizza Paradise • Preparing', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Featured Stores
              const SectionHeader(title: 'Featured Stores', actionText: 'See All'),
              const SizedBox(height: 10),
              SizedBox(
                height: 210,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemCount: MockData.stores.length,
                  itemBuilder: (context, index) {
                    final store = MockData.stores[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.storeDetail, arguments: store),
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Container(
                                height: 110,
                                width: double.infinity,
                                color: AppColors.surfaceVariant,
                                child: Stack(
                                  children: [
                                    Center(child: Icon(Icons.storefront_rounded, size: 40, color: AppColors.primary.withValues(alpha: 0.3))),
                                    if (store['freeDelivery'] == true)
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: AppColors.success,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text('Free Delivery', style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white)),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(store['name'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded, size: 16, color: AppColors.secondary),
                                      const SizedBox(width: 3),
                                      Text('${store['rating']}', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                                      const SizedBox(width: 8),
                                      Icon(Icons.access_time_rounded, size: 13, color: AppColors.textHint),
                                      const SizedBox(width: 3),
                                      Text(store['eta'] as String, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Popular near you
              const SectionHeader(title: 'Popular Near You', actionText: 'See All'),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final store = MockData.stores[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.storeDetail, arguments: store),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.restaurant_rounded, color: AppColors.primary.withValues(alpha: 0.4), size: 30),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(store['name'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text('${store['category']} • ${store['distance']}', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star_rounded, size: 15, color: AppColors.secondary),
                                    const SizedBox(width: 3),
                                    Text('${store['rating']} (${store['reviews']})', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                                    const SizedBox(width: 10),
                                    Icon(Icons.access_time_rounded, size: 13, color: AppColors.textHint),
                                    const SizedBox(width: 3),
                                    Text(store['eta'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
