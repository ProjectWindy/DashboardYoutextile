import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ipad_dashboard/core/assets.dart';

import '../../../bloc/shipping_unit/shipping_unit_bloc.dart';

class ShipScreen extends StatefulWidget {
  const ShipScreen({super.key});

  @override
  State<ShipScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<ShipScreen> {
  bool isActive = true;

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Thêm Đơn vị vận chuyển"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddShippingUnitDialog(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.filter_alt_outlined, color: Colors.blue),
                  onPressed: () {
                    // Implement filter functionality
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(
                    child: Center(
                  child: Text("STT",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                )),
                // Expanded(
                //     flex: 2,
                //     child: Center(
                //       child: Text("Hình ảnh",
                //           style: TextStyle(
                //               fontSize: 14, fontWeight: FontWeight.bold)),
                //     )),
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
                                // Expanded(
                                //     flex: 2,
                                //     child: Container(
                                //       height: 30,
                                //       width: 30,
                                //       margin: const EdgeInsets.symmetric(
                                //           horizontal: 5, vertical: 5),
                                //       decoration: BoxDecoration(
                                //           color: Colors.grey.shade200,
                                //           image: DecorationImage(
                                //               image: NetworkImage(
                                //                   "${NetworkConstants.urlImage}${unit.image}"),
                                //               fit: BoxFit.fitWidth)),
                                //     )),
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
                                            // Hiện dialog xác nhận trước khi xóa
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title:
                                                    const Text('Xác nhận xóa'),
                                                content: const Text(
                                                    'Bạn có chắc chắn muốn xóa đơn vị vận chuyển này?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text('Hủy'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              ShippingUnitBloc>()
                                                          .add(
                                                            DeleteShippingUnitEvent(
                                                                uuid:
                                                                    unit.uuid),
                                                          );
                                                      Navigator.pop(context);
                                                    },
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          Colors.red,
                                                    ),
                                                    child: const Text('Xóa'),
                                                  ),
                                                ],
                                              ),
                                            );
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
  bool isActive = true;

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: BlocConsumer<ShippingUnitBloc, ShippingUnitState>(
            listener: (context, state) {
              if (state is ShippingUnitSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Đơn vị vận chuyển đã được thêm!")),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Chỉnh sửa đơn vị vận chuyển",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Tên đơn vị",
                      hintText: "Nhập tên đơn vị vận chuyển",
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: CheckboxListTile(
                      title: const Text(
                        'Trạng thái hoạt động',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        isActive ? 'Đang hoạt động' : 'Không hoạt động',
                        style: TextStyle(
                          color: isActive ? Colors.green : Colors.red,
                        ),
                      ),
                      value: isActive,
                      onChanged: (bool? value) {
                        setState(() {
                          isActive = value ?? true;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _selectedImage == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload_outlined,
                                    size: 48, color: Colors.grey.shade400),
                                const SizedBox(height: 8),
                                TextButton.icon(
                                  onPressed: _pickImage,
                                  icon: const Icon(
                                      Icons.add_photo_alternate_outlined),
                                  label: const Text("Chọn hình ảnh"),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Image.file(_selectedImage!, fit: BoxFit.cover),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: IconButton(
                                  onPressed: () =>
                                      setState(() => _selectedImage = null),
                                  icon: const Icon(Icons.close,
                                      color: Colors.black54),
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.all(4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: state is ShippingUnitLoading
                          ? null
                          : () async {
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

                              final multipartFile =
                                  await MultipartFile.fromFile(
                                _selectedImage!.path,
                                filename: _selectedImage!.path.split('/').last,
                              );

                              context.read<ShippingUnitBloc>().add(
                                    AddShippingUnitButtonPressed(
                                      name: name,
                                      status: status,
                                      description: '',
                                      image: multipartFile,
                                    ),
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: state is ShippingUnitLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Lưu thay đổi",
                              style: TextStyle(fontSize: 15),
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class AddShippingUnitDialog extends StatefulWidget {
  const AddShippingUnitDialog({super.key});

  @override
  State<AddShippingUnitDialog> createState() => _AddShippingUnitDialogState();
}

class _AddShippingUnitDialogState extends State<AddShippingUnitDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _selectedImage;
  bool isActive = true;

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Thêm đơn vị vận chuyển",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Tên đơn vị",
                  hintText: "Nhập tên đơn vị vận chuyển",
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Mô tả",
                  hintText: "Nhập mô tả cho đơn vị vận chuyển",
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedImage == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_upload_outlined,
                                size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 8),
                            TextButton.icon(
                              onPressed: _pickImage,
                              icon: const Icon(
                                  Icons.add_photo_alternate_outlined),
                              label: const Text("Chọn hình ảnh"),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(_selectedImage!, fit: BoxFit.cover),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: IconButton(
                                onPressed: () =>
                                    setState(() => _selectedImage = null),
                                icon: const Icon(Icons.close),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: CheckboxListTile(
                  title: const Text(
                    'Trạng thái hoạt động',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    isActive ? 'Đang hoạt động' : 'Không hoạt động',
                    style: TextStyle(
                      color: isActive ? Colors.green : Colors.red,
                    ),
                  ),
                  value: isActive,
                  onChanged: (bool? value) {
                    setState(() {
                      isActive = value ?? true;
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty ||
                        _descriptionController.text.isEmpty ||
                        _selectedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Vui lòng điền đầy đủ thông tin"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }

                    final multipartFile = await MultipartFile.fromFile(
                      _selectedImage!.path,
                      filename: _selectedImage!.path.split('/').last,
                    );

                    if (mounted) {
                      context.read<ShippingUnitBloc>().add(
                            AddShippingUnitButtonPressed(
                              name: _nameController.text,
                              description: _descriptionController.text,
                              image: multipartFile,
                              status: isActive ? 'active' : 'inactive',
                            ),
                          );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Thêm mới",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
