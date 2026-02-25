import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/widgets/common_widgets.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ticket = Get.arguments as Map<String, dynamic>;
    final status = (ticket['status'] as String).obs;
    final messages = (ticket['messages'] as List<dynamic>?) ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Ticket #${ticket['id']}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text(ticket['subject'] as String, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700))),
                            Obx(() => StatusChip(label: status.value, color: statusColor(status.value))),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _infoChip(Icons.person_rounded, ticket['user'] as String),
                            const SizedBox(width: 10),
                            _infoChip(Icons.calendar_today_rounded, ticket['date'] as String),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _infoChip(Icons.flag_rounded, 'Priority: ${ticket['priority']}'),
                            const SizedBox(width: 10),
                            _infoChip(Icons.category_rounded, ticket['category'] ?? 'General'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text('Conversation', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 14),

                  // Messages
                  ...messages.map((msg) {
                    final m = msg as Map<String, dynamic>;
                    final isAdmin = m['from'] == 'Admin';
                    return Align(
                      alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                        decoration: BoxDecoration(
                          color: isAdmin ? AppColors.adminColor : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isAdmin ? 16 : 4),
                            bottomRight: Radius.circular(isAdmin ? 4 : 16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m['from'] as String, style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isAdmin ? Colors.white70 : AppColors.textSecondary,
                            )),
                            const SizedBox(height: 4),
                            Text(m['message'] as String, style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: isAdmin ? Colors.white : AppColors.textPrimary,
                            )),
                            const SizedBox(height: 4),
                            Text(m['time'] as String, style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: isAdmin ? Colors.white54 : AppColors.textHint,
                            )),
                          ],
                        ),
                      ),
                    );
                  }),

                  if (messages.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: [
                          Icon(Icons.chat_bubble_outline_rounded, size: 48, color: AppColors.textHint),
                          const SizedBox(height: 8),
                          Text('No messages yet', style: GoogleFonts.poppins(color: AppColors.textHint)),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Status actions
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: OutlinedButton(
                            onPressed: () {
                              status.value = 'In Progress';
                              Get.snackbar('Updated', 'Ticket assigned to you', snackPosition: SnackPosition.BOTTOM);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.adminColor,
                              side: const BorderSide(color: AppColors.adminColor),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text('Assign to Me', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () {
                              status.value = 'Resolved';
                              Get.snackbar('Resolved', 'Ticket has been resolved', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text('Resolve', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Reply bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a reply...',
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.adminColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () => Get.snackbar('Sent', 'Reply sent to user', snackPosition: SnackPosition.BOTTOM),
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(text, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
