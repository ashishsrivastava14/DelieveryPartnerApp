import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';
import 'package:delivery_partner_app/core/routes/app_routes.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class SupportTicketsScreen extends StatelessWidget {
  const SupportTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = 'All'.obs;
    final filters = ['All', 'Open', 'In Progress', 'Resolved'];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Stats
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(child: _statCard('Open', '${MockData.supportTickets.where((t) => t['status'] == 'Open').length}', Colors.red)),
                const SizedBox(width: 10),
                Expanded(child: _statCard('In Progress', '${MockData.supportTickets.where((t) => t['status'] == 'In Progress').length}', Colors.orange)),
                const SizedBox(width: 10),
                Expanded(child: _statCard('Resolved', '${MockData.supportTickets.where((t) => t['status'] == 'Resolved').length}', Colors.green)),
              ],
            ),
          ),

          // Filter chips
          SizedBox(
            height: 44,
            child: Obx(() => ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final f = filters[index];
                final isSelected = selectedFilter.value == f;
                return GestureDetector(
                  onTap: () => selectedFilter.value = f,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.adminColor : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(f, style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    )),
                  ),
                );
              },
            )),
          ),
          const SizedBox(height: 10),

          // Ticket list
          Expanded(
            child: Obx(() {
              final tickets = selectedFilter.value == 'All'
                  ? MockData.supportTickets
                  : MockData.supportTickets.where((t) => t['status'] == selectedFilter.value).toList();

              if (tickets.isEmpty) {
                return Center(child: Text('No tickets found', style: GoogleFonts.poppins(color: AppColors.textHint)));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(20),
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  final priority = ticket['priority'] as String;
                  final priorityColor = priority == 'High'
                      ? Colors.red
                      : priority == 'Medium'
                          ? Colors.orange
                          : Colors.green;

                  return GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.ticketDetail, arguments: ticket),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border(left: BorderSide(color: priorityColor, width: 4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('#${ticket['id']}', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                              const Spacer(),
                              StatusChip(label: ticket['status'] as String, color: statusColor(ticket['status'] as String)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(ticket['subject'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.person_rounded, size: 14, color: AppColors.textHint),
                              const SizedBox(width: 4),
                              Text(ticket['user'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                              const SizedBox(width: 14),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: priorityColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                                child: Text(priority, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: priorityColor)),
                              ),
                              const Spacer(),
                              Text(ticket['date'] as String, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textHint)),
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

  Widget _statCard(String label, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(count, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: color)),
          Text(label, style: GoogleFonts.poppins(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
