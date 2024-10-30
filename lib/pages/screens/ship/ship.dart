import 'package:flutter/material.dart';
import 'package:ipad_dashboard/core/assets.dart';

class ShipScreen extends StatefulWidget {
  const ShipScreen({Key? key}) : super(key: key);

  @override
  State<ShipScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<ShipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Đơn vị vận chuyển",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            Text(
              "Quản lý đơn vị vận chuyển",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon:
                      const Icon(Icons.filter_alt_outlined, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xFFFAFAFA),
                    ),
                    dataRowHeight: 69,
                    horizontalMargin: 30,
                    columnSpacing: 100,
                    columns: const [
                      DataColumn(
                          label: Text('STT',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Tên',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Số Đơn Hàng',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Tỉ Lệ Hoàn Thành',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Tình Trạng',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Thao tác',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                    ],
                    rows: List.generate(
                      7,
                      (index) => DataRow(
                        cells: [
                          DataCell(Text('#123')),
                          DataCell(
                              Text(index == 1 ? 'VNPost' : "Viettel Post")),
                          DataCell(Text('500')),
                          DataCell(Text(index == 1 ? '95%' : '90%')),
                          DataCell(Text(index == 1 ? 'Hoạt động' : 'Ngưng')),
                          DataCell(_buildActions()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildPagination(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 59,
      height: 57,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
              Asset.bgImageAvatar), // Thay thế bằng đường dẫn ảnh của bạn
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: 30, color: Colors.blue),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.delete_outline, size: 30, color: Colors.red[300]),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPaginationButton('<'),
        ...List.generate(
          4,
          (index) => _buildPaginationButton('${index + 1}'),
        ),
        _buildPaginationButton('>'),
      ],
    );
  }

  Widget _buildPaginationButton(String label) {
    return TextButton(
      onPressed: () {},
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }
}
