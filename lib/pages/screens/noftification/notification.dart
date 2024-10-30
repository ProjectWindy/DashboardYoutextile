import 'package:flutter/material.dart';
import 'package:ipad_dashboard/core/colors/color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm đơn đăng ký',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color(0xFFFAFAFA),
                  ),
                  columnSpacing: 100,
                  horizontalMargin: 30,
                  dataRowHeight: 69,
                  columns: const [
                    DataColumn(
                        label: Text('Tên Mall',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Thành viên',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Email',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Hành động',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                  ],
                  rows: List.generate(
                    5,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text(
                            index == 1
                                ? 'Sneaker Store'
                                : index == 2
                                    ? 'Tech Shop'
                                    : index == 3
                                        ? 'Coffee House'
                                        : index == 4
                                            ? 'Fashion Boutique'
                                            : 'Art Studio',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ))),
                        DataCell(Text('John Doe',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Styles.blue))),
                        DataCell(Text('john@gmail.com',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Styles.blue))),
                        DataCell(Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {},
                              child: const Text('Approve'),
                            ),
                            const SizedBox(width: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {},
                              child: const Text('Reject'),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
