import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RevenueManagementPage(),
    );
  }
}

class RevenueManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý doanh thu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Tất cả các mall',
                      border: OutlineInputBorder(),
                    ),
                    items: ["Mall 1", "Mall 2", "Mall 3"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Chọn kỳ',
                      border: OutlineInputBorder(),
                    ),
                    items: ["Theo Quý", "Theo Năm"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Lọc dữ liệu"),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("Xuất Excel"),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('STT')),
                    DataColumn(label: Text('Tên Mall')),
                    DataColumn(label: Text('Doanh Thu Tạm Thời')),
                    DataColumn(label: Text('Doanh Thu')),
                    DataColumn(label: Text('Số Lượng Đơn Hàng')),
                    DataColumn(label: Text('Số Lượng Đơn Hàng Đã Hoàn Thành')),
                    DataColumn(label: Text('Số Lượng Đơn Hàng Đang Chờ')),
                    DataColumn(label: Text('Ngày Cập Nhật Cuối')),
                  ],
                  rows: List.generate(
                    10,
                    (index) => DataRow(cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text('Mall ${index + 1}')),
                      DataCell(Text('1,000,000')),
                      DataCell(Text('1,200,000')),
                      DataCell(Text('100')),
                      DataCell(Text('80')),
                      DataCell(Text('20')),
                      DataCell(Text('2024-10-28')),
                    ]),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 250,
              child: RevenueBarChart(),
            ),
          ],
        ),
      ),
    );
  }
}

class RevenueBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 3000000,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Color(0xff7589a2),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                );
                switch (value.toInt()) {
                  case 0:
                    return Text('Mall 1', style: style);
                  case 1:
                    return Text('Mall 2', style: style);
                  case 2:
                    return Text('Mall 3', style: style);
                  case 3:
                    return Text('Mall 4', style: style);
                  case 4:
                    return Text('Mall 5', style: style);
                  default:
                    return Text('', style: style);
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 500000,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text('${value ~/ 1000000}M');
              },
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 1000000,
                color: Colors.red,
                width: 15,
              ),
              BarChartRodData(
                toY: 1200000,
                color: Colors.blue,
                width: 15,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 2000000,
                color: Colors.red,
                width: 15,
              ),
              BarChartRodData(
                toY: 2100000,
                color: Colors.blue,
                width: 15,
              ),
            ],
          ),
          // Thêm các nhóm BarChartGroupData khác cho các mall còn lại...
        ],
      ),
    );
  }
}
