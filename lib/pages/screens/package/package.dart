import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipad_dashboard/blocs/service_packages/service_packages_bloc.dart';
import 'package:ipad_dashboard/blocs/service_packages/service_packages_state.dart';
import 'package:ipad_dashboard/blocs/service_packages/service_packages_event.dart';
import 'package:intl/intl.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ServicePackagesBloc>().add(LoadServicePackages());
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
              "Gói thành viên",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            Text(
              "Quản lý gói thành viên",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<ServicePackagesBloc, ServicePackagesState>(
        builder: (context, state) {
          if (state is ServicePackagesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ServicePackagesError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is ServicePackagesLoaded) {
            return _buildContent(state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(ServicePackagesLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Thêm gói"),
                onPressed: () {
                  // Implement add package functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined, color: Colors.blue),
                onPressed: () {
                  // Implement filter functionality
                },
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
                                fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Tên gói',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Giá gốc',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Giá giảm',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Thời hạn (ngày)',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Trạng thái',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Thao tác',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
                  ],
                  rows: List.generate(
                    state.packages.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text('${index + 1}',
                            style: const TextStyle(fontSize: 15))),
                        DataCell(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.packages[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                state.packages[index].shortDescription,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text(
                            '${_formatPrice(state.packages[index].originalPrice)}đ')),
                        DataCell(Text(state.packages[index].discountPrice !=
                                null
                            ? '${_formatPrice(state.packages[index].discountPrice!)}đ'
                            : '-')),
                        DataCell(
                            Text(state.packages[index].duration.toString())),
                        DataCell(
                            _buildStatusBadge(state.packages[index].status)),
                        DataCell(_buildActions(state.packages[index].uuid)),
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

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'active':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        displayText = 'Hoạt động';
        break;
      case 'inactive':
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        displayText = 'Ngưng hoạt động';
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
        displayText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        displayText,
        style: TextStyle(color: textColor, fontSize: 12),
      ),
    );
  }

  String _formatPrice(String price) {
    // Convert string to double
    double priceValue = double.tryParse(price) ?? 0;
    // Format with thousands separator
    return NumberFormat('#,###').format(priceValue);
  }

  Widget _buildActions(String packageId) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: 30, color: Colors.blue),
          onPressed: () {
            // Implement edit functionality
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_outline, size: 30, color: Colors.red[300]),
          onPressed: () {
            _showDeleteConfirmation(packageId);
          },
        ),
      ],
    );
  }

  Future<void> _showDeleteConfirmation(String packageId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: const Text('Bạn có chắc chắn muốn xóa gói dịch vụ này?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                // context
                //     .read<ServicePackagesBloc>()
                //     .add(DeleteServicePackage(packageId));
                // Navigator.of(context).pop();
              },
              child: const Text('Xóa'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
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
      onPressed: () {
        if (label != '<' && label != '>') {
          context.read<ServicePackagesBloc>().add(
                LoadServicePackages(page: int.parse(label)),
              );
        }
      },
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
