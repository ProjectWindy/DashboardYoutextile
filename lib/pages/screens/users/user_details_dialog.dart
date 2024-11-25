import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipad_dashboard/blocs/user/user_bloc.dart';
import 'package:ipad_dashboard/blocs/user/user_event.dart';
import 'package:ipad_dashboard/blocs/user/user_state.dart';
import 'package:ipad_dashboard/services/restful_api_provider.dart';

class UserDetailsDialog extends StatelessWidget {
  final String uuid;

  const UserDetailsDialog({Key? key, required this.uuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => UserBloc(
            apiProvider: context.read<RestfulApiProviderImpl>(),
          )..add(LoadUserDetails(uuid)),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is UserError) {
                return Center(child: Text('Error: ${state.message}'));
              }

              if (state is UserLoaded) {
                final user = state.user;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chi tiết người dùng',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSection(
                              'Thông tin cá nhân',
                              [
                                _buildInfoRow('Họ tên:', user.name),
                                _buildInfoRow('Email:', user.email),
                                _buildInfoRow('Số điện thoại:', user.phone),
                                if (user.gender != null)
                                  _buildInfoRow('Giới tính:', user.gender!),
                                if (user.birthday != null)
                                  _buildInfoRow('Ngày sinh:', user.birthday!),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildSection(
                              'Thông tin tài khoản',
                              [
                                _buildInfoRow('Loại tài khoản:', user.type),
                                _buildInfoRow('Vai trò:', user.role),
                                _buildInfoRow('Trạng thái:', user.status),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
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
          ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
