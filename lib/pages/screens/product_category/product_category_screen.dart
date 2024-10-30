import 'package:flutter/material.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Sản phẩm và danh mục",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Sản phẩm"),
            Tab(text: "Danh mục"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProductTab(),
          const Center(
              child: Text("Danh mục",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildProductTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quản lý sản phẩm và danh mục",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                onPressed: () {},
                color: Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
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
                        label: Text('Tên Mall',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Tên sản phẩm',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Tên Danh Mục',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Giá',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Số lượng',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Thao tác',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                  ],
                  rows: List.generate(
                    6,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text('#123',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                        DataCell(Text('SangCaby',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                        DataCell(Text('Vải cabybara',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                        DataCell(Text('Danh mục A',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                        DataCell(Text('200.000VND',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                        DataCell(Text('69',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                        DataCell(
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red[300],
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('<'),
              ),
              ...List.generate(
                4,
                (index) => TextButton(
                  onPressed: () {},
                  child: Text('${index + 1}'),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('>'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
