import 'package:flutter/material.dart';
import 'package:ipad_dashboard/blocs/user/user_bloc.dart';
import 'package:ipad_dashboard/blocs/user/user_event.dart';
import 'package:ipad_dashboard/blocs/user/user_state.dart';
import 'package:ipad_dashboard/blocs/users/users_bloc.dart';
import 'package:ipad_dashboard/core/assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipad_dashboard/pages/screens/user/user_details.dart';
import 'package:ipad_dashboard/pages/screens/users/user_details_dialog.dart';
import 'package:ipad_dashboard/services/restful_api_provider.dart';

import '../../../blocs/users/users_event.dart';
import '../../../blocs/users/users_state.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(LoadUsers());
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
              "Người dùng",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            Text(
              "Quản lý Tài Khoản",
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
                child: BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state is UsersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is UsersError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is UsersLoaded) {
                      return SingleChildScrollView(
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Tên',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Email',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                            // DataColumn(
                            //     label: Text('Avatar',
                            //         style: TextStyle(
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Tình Trạng',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Ngày Bắt Đầu',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Ngày Kết Thúc',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Gói',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Thao tác',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                          ],
                          rows: state.users.map((user) {
                            return DataRow(
                              cells: [
                                DataCell(Text('#${user.uuid.substring(0, 4)}')),
                                DataCell(Text(user.name)),
                                DataCell(Text('${user.name}@gmail.com')),
                                // DataCell(_buildAvatar(user.image)),
                                DataCell(Text(user.status)),
                                DataCell(Text('2024-01-10')),
                                DataCell(Text('2024-01-10')),
                                DataCell(Text('1.990.000 VND')),
                                DataCell(_buildActions(user.uuid)),
                              ],
                            );
                          }).toList(),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
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

  Widget _buildAvatar([String? imageUrl]) {
    return Container(
      width: 59,
      height: 57,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imageUrl != null
              ? NetworkImage(imageUrl)
              : AssetImage(Asset.bgImageAvatar) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildActions(String uuid) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: 30, color: Colors.blue),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Chi tiết người dùng',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                      // Content
                      BlocProvider(
                        create: (context) => UserBloc(
                          apiProvider: context.read<RestfulApiProviderImpl>(),
                        )..add(LoadUserDetails(uuid)),
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return const Padding(
                                padding: EdgeInsets.all(24.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }

                            if (state is UserError) {
                              return Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Center(
                                    child: Text('Error: ${state.message}')),
                              );
                            }

                            if (state is UserLoaded) {
                              final user = state.user;
                              return Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSection(
                                      'Thông tin cá nhân',
                                      [
                                        _buildInfoRow('Họ tên:', user.name),
                                        _buildInfoRow('Email:', user.email),
                                        _buildInfoRow(
                                            'Số điện thoại:', user.phone),
                                      ],
                                    ),
                                    const Divider(height: 32),
                                    _buildSection(
                                      'Thông tin tài khoản',
                                      [
                                        _buildInfoRow(
                                            'Loại tài khoản:', user.type),
                                        _buildInfoRow('Vai trò:', user.role),
                                        _buildInfoRow(
                                            'Trạng thái:', user.status),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_outline, size: 30, color: Colors.red[300]),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    // Helper function to format value
    String formatValue(String val) {
      switch (val.toLowerCase()) {
        case 'free':
          return 'Miễn phí';
        case 'user':
          return 'Người dùng';
        case 'active':
          return 'Hoạt động';
        case 'inactive':
          return 'Không hoạt động';
        default:
          return val;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              formatValue(value), // Format the value
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
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
