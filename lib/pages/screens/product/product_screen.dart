import 'package:flutter/material.dart';
import 'package:ipad_dashboard/core/assets.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
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
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sản phẩm",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            Text(
              "Quản lý sản phẩm và danh mục",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorWeight: 3,
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
          const Center(child: Text("Danh mục")),
        ],
      ),
    );
  }

  Widget _buildProductTab() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildActionButton(
                icon: Icons.add_box_outlined,
                onPressed: () {
                  _showAddAdminDialog(context);
                },
              ),
              const SizedBox(height: 8),
              _buildActionButton(
                icon: Icons.filter_alt_outlined,
                onPressed: () {},
              ),
            ],
          ),
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
                        label: Text('Tên danh mục',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Mô tả',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Tình trạng',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Hình ảnh',
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
                    7,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text('#123')),
                        DataCell(Text('SangCaby')),
                        DataCell(Text('Vải cabybara')),
                        DataCell(_buildStatusBadge(index == 1)),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              Asset.imgProductVai,
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        DataCell(Text('69')),
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
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: Colors.blue,
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildStatusBadge(bool inactive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: inactive ? Colors.grey[200] : Colors.lightGreen[100],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        inactive ? 'Ngưng' : 'Hoạt động',
        style: TextStyle(
          color: inactive ? Colors.grey[800] : Colors.green[800],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(
            Icons.edit_outlined,
            size: 18,
            color: Colors.blue,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            size: 18,
            color: Colors.red[300],
          ),
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

  Widget _buildPaginationButton(String label, {bool isActive = false}) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: isActive ? Colors.white : Colors.black87,
        backgroundColor: isActive ? Colors.blue : Colors.transparent,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

void _showAddAdminDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 400, // Đặt kích thước cố định cho dialog
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(0, 255, 255, 255), // Light blue
              Color.fromARGB(0, 255, 255, 255), // Light blue
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Thêm danh mục sản phẩm mới",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              _buildTextField("Tên danh mục:"),
              SizedBox(height: 10),
              _buildTextField("Mô tả chi tiết:"),
              SizedBox(height: 10),
              SizedBox(height: 10),
              _buildDropdownField(
                  "Trạng thái", ["Đang hoạt động", "Đã vô hiệu"]),
              SizedBox(height: 16),
              Text("Avatar", style: TextStyle(fontSize: 14)),
              SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  // Chọn ảnh từ thư viện
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text("Choose file",
                    style: TextStyle(color: Colors.black54)),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height / 20,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF218FF2), // Light blue
                      Color(0xFF13538C), // Dark blue
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(
                    //     context,
                    //     '/CustomNavBar'
                    //     '');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Thêm Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildTextField(String hint, {bool isPassword = false}) {
  return TextField(
    obscureText: isPassword,
    decoration: InputDecoration(
      hintText: hint,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.black12),
      ),
    ),
  );
}

Widget _buildDropdownField(String label, List<String> items) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontSize: 14),
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    items: items.map((item) {
      return DropdownMenuItem(
        value: item,
        child: Text(item, style: TextStyle(fontSize: 14)),
      );
    }).toList(),
    onChanged: (value) {},
  );
}
