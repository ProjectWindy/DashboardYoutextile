import 'package:flutter/material.dart';
import 'package:ipad_dashboard/core/assets.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thông tin cá nhân",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            PersonalInfoCard(),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Quản lý Admin",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_box_sharp, color: Colors.blue),
                  onPressed: () {
                    _showAddAdminDialog(context);
                  },
                ),
                IconButton(
                  icon:
                      const Icon(Icons.filter_alt_outlined, color: Colors.blue),
                  onPressed: () {
                    _showAddAdminDialog(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            AdminManagementTable(),
          ],
        ),
      ),
    );
  }
}

class PersonalInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phần hiển thị ảnh đại diện và tên
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage:
                      AssetImage(Asset.imgProductTho), // Đổi thành ảnh của bạn
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tên",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Jonathan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () {
                    // Chức năng chỉnh sửa tên
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300, thickness: 1),
            const SizedBox(height: 16),

            // Phần hiển thị mật khẩu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mật khẩu",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "*********",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () {
                    // Chức năng chỉnh sửa mật khẩu
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AdminManagementTable extends StatelessWidget {
  final List<Map<String, dynamic>> admins = [
    {
      "id": "MK1",
      "name": "MK1",
      "email": "abc@gmail.com",
      "role": "QL sản phẩm",
      "status": "Hoạt động"
    },
    {
      "id": "MK2",
      "name": "MK2",
      "email": "abc@gmail.com",
      "role": "QL thành viên",
      "status": "Bị khóa"
    },
    {
      "id": "MK3",
      "name": "MK3",
      "email": "abc@gmail.com",
      "role": "QL DVVC",
      "status": "Hoạt động"
    },
    {
      "id": "MK4",
      "name": "MK4",
      "email": "abc@gmail.com",
      "role": "QL doanh thu",
      "status": "Bị khóa"
    },
    {
      "id": "MK5",
      "name": "MK5",
      "email": "abc@gmail.com",
      "role": "QL sản phẩm",
      "status": "Hoạt động"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith(
            (states) => const Color(0xFFFAFAFA),
          ),
          dataRowHeight: 69,
          horizontalMargin: 30,
          columnSpacing: 100,
          columns: [
            DataColumn(
                label: Text("STT",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Họ và tên",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Avatar",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Email",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Vai trò",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Trạng thái",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("Thao tác",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          ],
          rows: List<DataRow>.generate(
            admins.length,
            (index) => DataRow(cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text(admins[index]["name"],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
              DataCell(CircleAvatar(
                radius: 30,
                backgroundImage:
                    AssetImage(Asset.bgImageAvatar), // Đổi thành ảnh của bạn
              )),
              DataCell(Text(admins[index]["email"],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
              DataCell(Text(admins[index]["role"],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
              DataCell(
                Text(
                  admins[index]["status"],
                  style: TextStyle(
                      color: admins[index]["status"] == "Bị khóa"
                          ? Colors.red
                          : Colors.green),
                ),
              ),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              )),
            ]),
          ),
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
                "Thêm Admin",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              _buildTextField("Họ và tên"),
              SizedBox(height: 10),
              _buildTextField("Email"),
              SizedBox(height: 10),
              _buildTextField("Mật khẩu", isPassword: true),
              SizedBox(height: 10),
              _buildTextField("Nhập lại mật khẩu", isPassword: true),
              SizedBox(height: 10),
              _buildDropdownField(
                  "Vai trò", ["QL sản phẩm", "QL đơn hàng", "QL người dùng"]),
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
