import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipad_dashboard/blocs/user/user_bloc.dart';
import 'package:ipad_dashboard/blocs/user/user_event.dart';
import 'package:ipad_dashboard/blocs/user/user_state.dart';
import 'package:ipad_dashboard/services/restful_api_provider.dart';

class UserDetailsScreen extends StatelessWidget {
  final String uuid;

  const UserDetailsScreen({Key? key, required this.uuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết người dùng'),
      ),
      body: BlocProvider(
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
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thông tin cá nhân',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow('Họ tên:', user.name),
                            _buildInfoRow('Email:', user.email),
                            _buildInfoRow('Số điện thoại:', user.phone),
                            if (user.gender != null)
                              _buildInfoRow('Giới tính:', user.gender!),
                            if (user.birthday != null)
                              _buildInfoRow('Ngày sinh:', user.birthday!),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thông tin tài khoản',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow('Loại tài khoản:', user.type),
                            _buildInfoRow('Vai trò:', user.role),
                            _buildInfoRow('Trạng thái:', user.status),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
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
              style: const TextStyle(fontWeight: FontWeight.bold),
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
