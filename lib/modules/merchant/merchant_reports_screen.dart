import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';

class MerchantReportsScreen extends StatelessWidget {
  const MerchantReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Reports', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Revenue Line Chart
            Text('Revenue - Last 7 Days', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Container(
              height: 220,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 5000,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: AppColors.border.withValues(alpha: 0.5),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < MockData.daysOfWeek.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(MockData.daysOfWeek[value.toInt()], style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textHint)),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(7, (i) => FlSpot(i.toDouble(), MockData.revenueLastWeek[i])),
                      isCurved: true,
                      color: AppColors.merchantColor,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.merchantColor.withValues(alpha: 0.1),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(radius: 4, color: AppColors.merchantColor, strokeWidth: 2, strokeColor: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Category Pie Chart
            Text('Category-wise Sales', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 30,
                        sections: MockData.categoryWiseSales.map((e) => PieChartSectionData(
                          value: e['value'] as double,
                          color: Color(e['color'] as int),
                          radius: 30,
                          showTitle: false,
                        )).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: MockData.categoryWiseSales.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: Color(e['color'] as int), borderRadius: BorderRadius.circular(3))),
                            const SizedBox(width: 8),
                            Expanded(child: Text(e['category'] as String, style: GoogleFonts.poppins(fontSize: 12))),
                            Text('${(e['value'] as double).toInt()}%', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Top Performing
            Text('Top Performing Items', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...() {
              final topItems = MockData.menuItems.toList()..sort((a, b) => (b['orderCount'] as int).compareTo(a['orderCount'] as int));
              return List.generate(5.clamp(0, topItems.length), (i) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: i == 0 ? AppColors.secondary : AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text('#${i + 1}', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: i == 0 ? Colors.white : AppColors.textPrimary))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(topItems[i]['name'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500))),
                    Text('${topItems[i]['orderCount']} orders', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.merchantColor, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              );
            }(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
