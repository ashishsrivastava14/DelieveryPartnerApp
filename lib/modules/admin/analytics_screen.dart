import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:delivery_partner_app/core/theme/app_theme.dart';
import 'package:delivery_partner_app/core/data/mock_data.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPeriod = 'Last 7 Days'.obs;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            Obx(() => Row(
              children: ['Last 7 Days', 'Last 30 Days', 'All Time'].map((p) {
                final isSelected = selectedPeriod.value == p;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => selectedPeriod.value = p,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.adminColor : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(p, style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                      )),
                    ),
                  ),
                );
              }).toList(),
            )),
            const SizedBox(height: 20),

            // Revenue Chart
            _chartCard(
              title: 'Revenue Trend',
              subtitle: '₹1,24,500 total',
              child: SizedBox(
                height: 200,
                child: LineChart(LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (val, _) {
                          final days = MockData.daysOfWeek;
                          if (val.toInt() >= 0 && val.toInt() < days.length) {
                            return Text(days[val.toInt()], style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textHint));
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: MockData.revenueLastWeek.asMap().entries.map((e) =>
                          FlSpot(e.key.toDouble(), e.value)).toList(),
                      isCurved: true,
                      color: AppColors.adminColor,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.adminColor.withValues(alpha: 0.1),
                      ),
                      dotData: FlDotData(show: false),
                    ),
                  ],
                )),
              ),
            ),
            const SizedBox(height: 16),

            // Orders Bar Chart
            _chartCard(
              title: 'Orders by Day',
              subtitle: '847 total orders',
              child: SizedBox(
                height: 200,
                child: BarChart(BarChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (val, _) {
                          final days = MockData.daysOfWeek;
                          if (val.toInt() >= 0 && val.toInt() < days.length) {
                            return Text(days[val.toInt()], style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textHint));
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: MockData.ordersPerDayOfWeek.asMap().entries.map((e) =>
                    BarChartGroupData(x: e.key, barRods: [
                      BarChartRodData(
                        toY: e.value,
                        color: AppColors.adminColor,
                        width: 22,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      ),
                    ]),
                  ).toList(),
                )),
              ),
            ),
            const SizedBox(height: 16),

            // User Growth
            _chartCard(
              title: 'User Growth',
              subtitle: '12,450 total users',
              child: SizedBox(
                height: 200,
                child: LineChart(LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        getTitlesWidget: (val, _) {
                          return Text('D${val.toInt() + 1}', style: GoogleFonts.poppins(fontSize: 9, color: AppColors.textHint));
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: MockData.userGrowth.asMap().entries.map((e) =>
                          FlSpot(e.key.toDouble(), e.value)).toList(),
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.green.withValues(alpha: 0.1),
                      ),
                      dotData: FlDotData(show: false),
                    ),
                  ],
                )),
              ),
            ),
            const SizedBox(height: 16),

            // Category Sales Pie
            _chartCard(
              title: 'Sales by Category',
              subtitle: 'Distribution of orders',
              child: SizedBox(
                height: 220,
                child: Row(
                  children: [
                    Expanded(
                      child: PieChart(PieChartData(
                        sectionsSpace: 3,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(value: 35, color: AppColors.primary, title: '35%', titleStyle: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white), radius: 50),
                          PieChartSectionData(value: 25, color: AppColors.secondary, title: '25%', titleStyle: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white), radius: 50),
                          PieChartSectionData(value: 20, color: Colors.green, title: '20%', titleStyle: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white), radius: 50),
                          PieChartSectionData(value: 12, color: AppColors.accent, title: '12%', titleStyle: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white), radius: 50),
                          PieChartSectionData(value: 8, color: Colors.teal, title: '8%', titleStyle: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white), radius: 50),
                        ],
                      )),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _legendItem(AppColors.primary, 'Food'),
                        _legendItem(AppColors.secondary, 'Grocery'),
                        _legendItem(Colors.green, 'Pharmacy'),
                        _legendItem(AppColors.accent, 'Electronics'),
                        _legendItem(Colors.teal, 'Others'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _chartCard({required String title, required String subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
          Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
          const SizedBox(width: 8),
          Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
