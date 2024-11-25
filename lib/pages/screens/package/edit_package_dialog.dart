import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipad_dashboard/blocs/service_packages/service_packages_bloc.dart';
import 'package:ipad_dashboard/blocs/service_packages/service_packages_event.dart';
import 'package:ipad_dashboard/blocs/service_packages/service_packages_state.dart';
import 'package:ipad_dashboard/models/service_package.dart';
import 'package:ipad_dashboard/util/add_success/add_success.dart';

class EditPackageDialog extends StatefulWidget {
  final ServicePackage package;

  const EditPackageDialog({Key? key, required this.package}) : super(key: key);

  @override
  _EditPackageDialogState createState() => _EditPackageDialogState();
}

class _EditPackageDialogState extends State<EditPackageDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _shortDescController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _discountPriceController;
  late TextEditingController _durationController;
  late bool _isOption;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.package.name);
    _shortDescController =
        TextEditingController(text: widget.package.shortDescription);
    _descController =
        TextEditingController(text: widget.package.shortDescription);
    _priceController =
        TextEditingController(text: widget.package.originalPrice.toString());
    _discountPriceController = TextEditingController(
        text: widget.package.discountPrice?.toString() ?? '');
    _durationController =
        TextEditingController(text: widget.package.duration.toString());
    _isOption = widget.package.isOption;
    _isActive = widget.package.status == 'active';
  }

  // Helper function to convert price string to double (in VND)
  double parseVNDPrice(String price) {
    // Convert from thousand VND to VND by multiplying with 1000
    return double.parse(price.replaceAll('đ', '').replaceAll(',', '')) * 1000;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServicePackagesBloc, ServicePackagesState>(
      listener: (context, state) {
        if (state is ServicePackagesSuccess) {
          Navigator.pop(context); // Đóng dialog edit
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: 'Thành Công',
              message: 'Cập nhật gói dịch vụ thành công',
            ),
          );
        } else if (state is ServicePackagesError) {
          Navigator.pop(context); // Đóng dialog edit
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: 'Thất Bại',
              message: 'Cập nhật gói dịch vụ thất bại: ${state.message}',
            ),
          );
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Chỉnh Sửa Gói Dịch Vụ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Hủy',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              final status = _isActive ? 'active' : 'inactive';
                              context.read<ServicePackagesBloc>().add(
                                    UpdateServicePackage(
                                      uuid: widget.package.uuid,
                                      name: _nameController.text,
                                      shortDescription:
                                          _shortDescController.text,
                                      description: _descController.text,
                                      originalPrice:
                                          parseVNDPrice(_priceController.text),
                                      discountPrice: _discountPriceController
                                              .text.isEmpty
                                          ? null
                                          : parseVNDPrice(
                                              _discountPriceController.text),
                                      duration:
                                          int.parse(_durationController.text),
                                      isOption: _isOption,
                                      status: status,
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF6366F1), // Indigo color
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Cập Nhật',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Form Content
              Flexible(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Tên gói dịch vụ',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tên gói dịch vụ';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _shortDescController,
                          decoration: const InputDecoration(
                            labelText: 'Mô tả ngắn',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mô tả ngắn';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Mô tả chi tiết',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mô tả chi tiết';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Giá (VNĐ)',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập giá';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _discountPriceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Giá giảm (VNĐ)',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final discountPrice = parseVNDPrice(value);
                                    final originalPrice =
                                        parseVNDPrice(_priceController.text);

                                    if (discountPrice >= originalPrice) {
                                      return 'Giá giảm phải nhỏ hơn giá gốc';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _durationController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Thời gian (Day)',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập thời gian';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: _isOption,
                              onChanged: (value) {
                                setState(() {
                                  _isOption = value ?? false;
                                });
                              },
                            ),
                            const Text('Là tùy chọn'),
                            const SizedBox(width: 24),
                            Checkbox(
                              value: _isActive,
                              onChanged: (value) {
                                setState(() {
                                  _isActive = value ?? false;
                                });
                              },
                            ),
                            const Text('Kích hoạt'),
                          ],
                        ),
                      ],
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

  @override
  void dispose() {
    _nameController.dispose();
    _shortDescController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _discountPriceController.dispose();
    _durationController.dispose();
    super.dispose();
  }
}
