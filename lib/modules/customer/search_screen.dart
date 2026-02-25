import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';

class CustomerSearchScreen extends StatelessWidget {
  const CustomerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final query = ''.obs;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Search', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (val) => query.value = val,
              decoration: InputDecoration(
                hintText: 'Search for dishes, restaurants...',
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textHint),
                suffixIcon: const Icon(Icons.tune_rounded, color: AppColors.primary),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              final results = query.value.isEmpty
                  ? MockData.searchResults
                  : MockData.searchResults
                      .where((e) => (e['name'] as String).toLowerCase().contains(query.value.toLowerCase()))
                      .toList();
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final item = results[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8),
                      ],
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
                          child: Icon(Icons.fastfood_rounded, color: AppColors.primary.withValues(alpha: 0.3)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                              Text(item['store'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded, size: 14, color: AppColors.secondary),
                                  const SizedBox(width: 3),
                                  Text('${item['rating']}', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text('₹${(item['price'] as double).toInt()}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary)),
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
}
