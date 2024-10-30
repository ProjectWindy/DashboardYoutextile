import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 24),
          // Top row cards
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'Người đăng ký mới',
                  subtitle: 'Số người đã đăng ký và sử dụng hệ thống.',
                  child: SizedBox(
                    height: 200,
                    child: LineChart(
                      _buildRegistrationLineChartData(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 0),
              Expanded(
                child: _buildMetricCard(
                  title: 'Đăng ký gói',
                  subtitle: 'Số gói hội viên đã được đăng ký trong tháng.',
                  child: SizedBox(
                    height: 200,
                    child: LineChart(
                      _buildPackageSignupLineChartData(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Revenue statistics section
          const Text(
            'Revenue statistics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const Text(
            'Thống kê chi tiết doanh thu từ đơn hàng, gói thuê bao.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 16),
          // Bottom row cards
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'Yêu cầu',
                  subtitle: 'Doanh thu từ các đơn hàng được tạo hàng tuần.',
                  topRightWidget: _buildGrowthIndicator(23.45),
                  child: SizedBox(
                    height: 200,
                    child: LineChart(
                      _buildRevenueLineChartData(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildMetricCard(
                  title: 'Gói',
                  subtitle: 'Doanh thu từ các gói thuê bao trong tuần.',
                  topRightWidget: _buildGrowthIndicator(23.45),
                  child: SizedBox(
                    height: 200,
                    child: LineChart(
                      _buildPackageRevenueLineChartData(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String subtitle,
    required Widget child,
    Widget? topRightWidget,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                if (topRightWidget != null) topRightWidget,
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthIndicator(double percentage) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '+${percentage.toStringAsFixed(2)}%',
        style: const TextStyle(
          color: Color(0xFF6366F1),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  LineChartData _buildRegistrationLineChartData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: _generateRandomSpots(20),
          isCurved: true,
          color: const Color(0xFF6366F1),
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: const Color(0xFF6366F1).withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  LineChartData _buildPackageSignupLineChartData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
              if (value.toInt() >= 0 && value.toInt() < months.length) {
                return Text(
                  months[value.toInt()],
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                );
              }
              return const Text('');
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: _generateRandomSpots(6, yMin: 25, yMax: 29),
          isCurved: true,
          color: const Color(0xFF6366F1),
          dotData: FlDotData(show: false),
        ),
        LineChartBarData(
          spots: _generateRandomSpots(6, yMin: 25, yMax: 29),
          isCurved: true,
          color: Colors.grey,
          dotData: FlDotData(show: false),
        ),
      ],
    );
  }

  LineChartData _buildRevenueLineChartData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: _generateRandomSpots(20, yMin: 0, yMax: 100, growth: true),
          isCurved: true,
          color: const Color(0xFF6366F1),
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6366F1).withOpacity(0.2),
                const Color(0xFF6366F1).withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  LineChartData _buildPackageRevenueLineChartData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: _generateRandomSpots(20, yMin: 0, yMax: 100, growth: true),
          isCurved: true,
          color: const Color(0xFF6366F1),
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6366F1).withOpacity(0.2),
                const Color(0xFF6366F1).withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _generateRandomSpots(
    int count, {
    double yMin = 0,
    double yMax = 100,
    bool growth = false,
  }) {
    final spots = <FlSpot>[];
    double lastY = (yMin + yMax) / 2;

    for (int i = 0; i < count; i++) {
      if (growth) {
        // For growth charts, tend upwards
        final change =
            (2 + Random().nextDouble() * 4) * (Random().nextBool() ? 1 : -0.5);
        lastY = min(yMax, max(yMin, lastY + change));
      } else {
        // For regular charts, move randomly
        final change =
            (Random().nextDouble() * 4) * (Random().nextBool() ? 1 : -1);
        lastY = min(yMax, max(yMin, lastY + change));
      }
      spots.add(FlSpot(i.toDouble(), lastY));
    }
    return spots;
  }
}
