import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipad_dashboard/blocs/service_packages/service_packages_event.dart';
import 'package:ipad_dashboard/blocs/service_packages/service_packages_state.dart';
import 'package:ipad_dashboard/util/add_success/add_success.dart';

import '../../../blocs/service_packages/service_packages_bloc.dart';

class CreatePackageDialog extends StatefulWidget {
  @override
  _CreatePackageDialogState createState() => _CreatePackageDialogState();
}

class _CreatePackageDialogState extends State<CreatePackageDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _shortDescController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  bool _isOption = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServicePackagesBloc, ServicePackagesState>(
      listener: (context, state) {
        if (state is ServicePackagesSuccess) {
          Navigator.pop(context); // Đóng form
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: 'Thành Công',
              message: state.message,
            ),
          );
        }

        if (state is ServicePackagesError) {
          Navigator.pop(context); // Đóng form
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: 'Thất Bại',
              message: state.message,
            ),
          );
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6, // 60% màn hình
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tạo Gói Dịch Vụ Mới',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Flexible(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Tên gói',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                                validator: (value) => value?.isEmpty ?? true
                                    ? 'Vui lòng nhập tên gói'
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _shortDescController,
                                decoration: InputDecoration(
                                  labelText: 'Mô tả ngắn',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                                validator: (value) => value?.isEmpty ?? true
                                    ? 'Vui lòng nhập mô tả ngắn'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descController,
                          decoration: InputDecoration(
                            labelText: 'Mô tả chi tiết',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          maxLines: 3,
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Vui lòng nhập mô tả chi tiết'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _priceController,
                                decoration: InputDecoration(
                                  labelText: 'Giá gốc',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  suffixText: 'VNĐ',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value?.isEmpty ?? true
                                    ? 'Vui lòng nhập giá gói'
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _durationController,
                                decoration: InputDecoration(
                                  labelText: 'Thời hạn',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  suffixText: 'Ngày',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value?.isEmpty ?? true
                                    ? 'Vui lòng nhập thời hạn'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text('Là tùy chọn'),
                          value: _isOption,
                          onChanged: (bool? value) {
                            setState(() {
                              _isOption = value ?? false;
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Hủy',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<ServicePackagesBloc>().add(
                              CreateServicePackage(
                                name: _nameController.text,
                                shortDescription: _shortDescController.text,
                                description: _descController.text,
                                originalPrice:
                                    double.parse(_priceController.text),
                                duration: int.parse(_durationController.text),
                                isOption: _isOption,
                              ),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Tạo',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
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
    _durationController.dispose();
    super.dispose();
  }
}
