import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchQuery = ''.obs;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            // Search
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (val) => searchQuery.value = val,
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textHint),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const TabBar(
              tabs: [
                Tab(text: 'Customers'),
                Tab(text: 'Riders'),
                Tab(text: 'Merchants'),
              ],
            ),
            Expanded(
              child: Obx(() {
                final q = searchQuery.value.toLowerCase();
                return TabBarView(
                  children: [
                    _buildUserList(MockData.adminUsers.where((u) => u['role'] == 'Customer' && (q.isEmpty || (u['name'] as String).toLowerCase().contains(q))).toList()),
                    _buildUserList(MockData.adminUsers.where((u) => u['role'] == 'Rider' && (q.isEmpty || (u['name'] as String).toLowerCase().contains(q))).toList()),
                    _buildUserList(MockData.adminUsers.where((u) => u['role'] == 'Merchant' && (q.isEmpty || (u['name'] as String).toLowerCase().contains(q))).toList()),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(List<Map<String, dynamic>> users) {
    if (users.isEmpty) {
      return Center(child: Text('No users found', style: GoogleFonts.poppins(color: AppColors.textHint)));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.userDetail, arguments: user),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.adminColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(child: Text(
                    (user['name'] as String).substring(0, 1),
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.adminColor),
                  )),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user['name'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                      Text(user['email'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                StatusChip(label: user['status'] as String, color: statusColor(user['status'] as String)),
              ],
            ),
          ),
        );
      },
    );
  }
}
