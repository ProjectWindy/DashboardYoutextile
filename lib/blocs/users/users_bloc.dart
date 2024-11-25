import 'package:bloc/bloc.dart';
import 'package:ipad_dashboard/models/user_model.dart';
import 'package:ipad_dashboard/util/token_manager.dart';

import '../../services/restful_api_provider.dart';
import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final RestfulApiProviderImpl apiProvider;

  UsersBloc({required this.apiProvider}) : super(UsersInitial()) {
    on<LoadUsers>(_onLoadUsers);
  }

  Future<void> _onLoadUsers(
    LoadUsers event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(UsersLoading());

      var token = await TokenManager.getToken();
      token ??= '3|abJ70ndnOBiNoxMCKunklCkQZUUHgqXT8umVQ7xW908f9b79';

      final response = await apiProvider.getUsers(token: token);
      final List<dynamic> usersJson = response.data['users'];
      final users = usersJson.map((json) => User.fromJson(json)).toList();

      emit(UsersLoaded(users));
    } catch (error) {
      emit(UsersError(error.toString()));
    }
  }
}
