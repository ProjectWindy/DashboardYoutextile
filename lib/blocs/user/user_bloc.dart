import 'package:bloc/bloc.dart';
import 'package:ipad_dashboard/blocs/user/user_event.dart';
import 'package:ipad_dashboard/blocs/user/user_state.dart';
import 'package:ipad_dashboard/models/user.dart';
import 'package:ipad_dashboard/services/restful_api_provider.dart';
import 'package:ipad_dashboard/util/token_manager.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final RestfulApiProviderImpl apiProvider;

  UserBloc({required this.apiProvider}) : super(UserInitial()) {
    on<LoadUserDetails>(_onLoadUserDetails);
  }

  Future<void> _onLoadUserDetails(
    LoadUserDetails event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoading());

      var token = await TokenManager.getToken();
      token ??= '3|abJ70ndnOBiNoxMCKunklCkQZUUHgqXT8umVQ7xW908f9b79';

      final response = await apiProvider.getUserDetails(
        token: token,
        uuid: event.uuid,
      );

      final user = User.fromJson(response.data['user']);
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}
