import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ipad_dashboard/core/assets.dart';
import 'package:ipad_dashboard/util/constants.dart';

import '../../../bloc/shipping_unit/shipping_unit_bloc.dart';

class ShipScreen extends StatefulWidget {
  const ShipScreen({super.key});

  @override
  State<ShipScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<ShipScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShippingUnitBloc>(context).add(FetchShippingUnitEvent());
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
            // Expanded(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(8),
            //       border: Border.all(color: const Color(0xFFEEEEEE)),
            //     ),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: DataTable(
            //         headingRowColor: MaterialStateColor.resolveWith(
            //           (states) => const Color(0xFFFAFAFA),
            //         ),
            //         dataRowHeight: 69,
            //         horizontalMargin: 30,
            //         columnSpacing: 100,
            //         columns: const [
            //           DataColumn(
            //               label: Text('STT',
            //                   style: TextStyle(
            //                       fontSize: 14, fontWeight: FontWeight.bold))),
            //           DataColumn(
            //               label: Text('Tên',
            //                   style: TextStyle(
            //                       fontSize: 14, fontWeight: FontWeight.bold))),
            //           DataColumn(
            //               label: Text('Số Đơn Hàng',
            //                   style: TextStyle(
            //                       fontSize: 14, fontWeight: FontWeight.bold))),
            //           DataColumn(
            //               label: Text('Tỉ Lệ Hoàn Thành',
            //                   style: TextStyle(
            //                       fontSize: 14, fontWeight: FontWeight.bold))),
            //           DataColumn(
            //               label: Text('Tình Trạng',
            //                   style: TextStyle(
            //                       fontSize: 14, fontWeight: FontWeight.bold))),
            //           DataColumn(
            //               label: Text('Thao tác',
            //                   style: TextStyle(
            //                       fontSize: 14, fontWeight: FontWeight.bold))),
            //         ],
            //         rows: List.generate(
            //           7,
            //           (index) => DataRow(
            //             cells: [
            //               DataCell(Text('#123')),
            //               DataCell(
            //                   Text(index == 1 ? 'VNPost' : "Viettel Post")),
            //               DataCell(Text('500')),
            //               DataCell(Text(index == 1 ? '95%' : '90%')),
            //               DataCell(Text(index == 1 ? 'Hoạt động' : 'Ngưng')),
            //               DataCell(_buildActions()),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const Row(
              children: [
                Expanded(
                    child: Center(
                  child: Text("STT",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                )),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Text("Hình ảnh",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    )),
                Expanded(
                    flex: 3,
                    child: Center(
                      child: Text("Đơn vị vận chuyển",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    )),
                Expanded(
                    flex: 1,
                    child: Center(
                      child: Text("Trạng thái",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    )),
                Expanded(
                    flex: 3,
                    child: Center(
                      child: Text("Chức năng",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    )),
              ],
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<ShippingUnitBloc, ShippingUnitState>(
                builder: (context, state) {
                  if (state is ShippingUnitLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ShippingUnitLoaded) {
                    final shippingUnits = state.shippingUnits;
                    return ListView.builder(
                      itemCount: shippingUnits.length,
                      itemBuilder: (context, index) {
                        final unit = shippingUnits[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Center(
                                  child: Text("$index",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${NetworkConstants.urlImage}${unit.image}"),
                                              fit: BoxFit.fitWidth)),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text(unit.name,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      backgroundColor: unit.status == "active"
                                          ? Colors.green
                                          : Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                    ),
                                    child: Text(
                                      unit.status,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white, // Đảm bảo chữ dễ đọc trên nền màu
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit_outlined,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {
                                            _showEditShippingDialog(context);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            // context.read<ShippingUnitCubit>().deleteShippingUnit(unit['uuid']);
                                          },
                                        ),
                                      ],
                                    ))),
                              ],
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    );
                  } else if (state is ShippingUnitError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('No data'));
                },
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
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(Asset.bgImageAvatar),
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

void _showEditShippingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
          child: const EditShippingUnitScreen(),
        ),
      );
    },
  );
}

class EditShippingUnitScreen extends StatefulWidget {
  const EditShippingUnitScreen({super.key});

  @override
  State<EditShippingUnitScreen> createState() => _EditShippingUnitScreenState();
}

class _EditShippingUnitScreenState extends State<EditShippingUnitScreen> {
  final _nameController = TextEditingController();
  final _statusController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ShippingUnitBloc, ShippingUnitState>(
          listener: (context, state) {
            if (state is ShippingUnitSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đơn vị vận chuyển đã được thêm!")),
              );
              Navigator.of(context).pop();
            } else if (state is ShippingUnitError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(onPressed:  () {
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.cancel)),
                ),
                const Center(
                  child: Text(
                    "Chỉnh sửa đơn vị vận chuyển",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Tên đơn vị"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _statusController,
                  decoration: const InputDecoration(labelText: "Trạng thái"),
                ),
                const SizedBox(height: 12),
                _selectedImage == null
                    ? const Text("Chưa chọn hình ảnh")
                    : Image.file(_selectedImage!, height: 100),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text("Chọn hình ảnh"),
                ),
                const SizedBox(height: 16),
                if (state is ShippingUnitLoading)
                  const CircularProgressIndicator(),
                ElevatedButton(
                  onPressed: () async {
                    final name = _nameController.text.trim();
                    final status = _statusController.text.trim();

                    if (name.isEmpty ||
                        status.isEmpty ||
                        _selectedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Vui lòng điền đầy đủ thông tin và chọn hình ảnh."),
                        ),
                      );
                      return;
                    }

                    final multipartFile = await MultipartFile.fromFile(
                      _selectedImage!.path,
                      filename: _selectedImage!.path.split('/').last,
                    );

                    context.read<ShippingUnitBloc>().add(
                          AddShippingUnitButtonPressed(
                            name: name,
                            status: status,
                            image: multipartFile,
                          ),
                        );
                  },
                  child: const Text("Lưu"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
// class AddShippingUnitScreen extends StatefulWidget {
//   const AddShippingUnitScreen({super.key});
//
//   @override
//   _AddShippingUnitScreenState createState() => _AddShippingUnitScreenState();
// }
//
// class _AddShippingUnitScreenState extends State<AddShippingUnitScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _statusController = TextEditingController();
//   File? _selectedImage;
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Thêm đơn vị vận chuyển'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Tên đơn vị',
//               style: TextStyle(fontSize: 16),
//             ),
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(
//                 hintText: 'Nhập tên đơn vị',
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Trạng thái',
//               style: TextStyle(fontSize: 16),
//             ),
//             TextField(
//               controller: _statusController,
//               decoration: const InputDecoration(
//                 hintText: 'Nhập trạng thái',
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Hình ảnh',
//               style: TextStyle(fontSize: 16),
//             ),
//             GestureDetector(
//               onTap: _pickImage,
//               child: Container(
//                 height: 150,
//                 width: double.infinity,
//                 color: Colors.grey[300],
//                 child: _selectedImage != null
//                     ? Image.file(_selectedImage!, fit: BoxFit.cover)
//                     : const Center(child: Text('Chọn hình ảnh')),
//               ),
//             ),
//             const SizedBox(height: 24),
//             BlocConsumer<ShippingUnitBloc, ShippingUnitState>(
//               listener: (context, state) {
//                 if (state is ShippingUnitSuccess) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Thêm thành công!')),
//                   );
//                   Navigator.pop(context);
//                 } else if (state is ShippingUnitError) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.message)),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 if (state is ShippingUnitLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 return ElevatedButton(
//                   onPressed: () {
//                     final name = _nameController.text.trim();
//                     final status = _statusController.text.trim();
//                     if (name.isNotEmpty && status.isNotEmpty && _selectedImage != null) {
//                       BlocProvider.of<ShippingUnitBloc>(context).add(
//                         AddShippingUnitButtonPressed(
//                           name: name,
//                           status: status,
//                           image: _selectedImage,
//                         ),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Vui lòng nhập đầy đủ thông tin và chọn hình ảnh!'),
//                         ),
//                       );
//                     }
//                   },
//                   child: const Text('Thêm'),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
