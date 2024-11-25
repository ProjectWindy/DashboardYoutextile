import 'package:bloc/bloc.dart';
import 'package:ipad_dashboard/blocs/service_packages/service_packages_event.dart';
import 'package:ipad_dashboard/blocs/service_packages/service_packages_state.dart';
import 'package:ipad_dashboard/models/service_package.dart';
import 'package:ipad_dashboard/services/restful_api_provider.dart';
import 'package:ipad_dashboard/util/token_manager.dart';

class ServicePackagesBloc
    extends Bloc<ServicePackagesEvent, ServicePackagesState> {
  final RestfulApiProviderImpl apiProvider;
  // final AuthBloc authBloc; // Assuming you have an AuthBloc for token management

  ServicePackagesBloc({
    required this.apiProvider,
    // required this.authBloc,
  }) : super(ServicePackagesInitial()) {
    on<LoadServicePackages>(_onLoadServicePackages);
    on<RefreshServicePackages>(_onRefreshServicePackages);
  }

  Future<void> _onLoadServicePackages(
    LoadServicePackages event,
    Emitter<ServicePackagesState> emit,
  ) async {
    try {
      emit(ServicePackagesLoading());

      // Get token from AuthBloc
      var token = await TokenManager.getToken();

      // Gán token mặc định nếu null
      token ??= '3|abJ70ndnOBiNoxMCKunklCkQZUUHgqXT8umVQ7xW908f9b79';

      final response = await apiProvider.getServicePackages(token: token);

      final List<dynamic> packagesJson =
          response.data['service_packages'] ?? [];
      final packages =
          packagesJson.map((json) => ServicePackage.fromJson(json)).toList();

      emit(ServicePackagesLoaded(packages));
    } catch (e) {
      emit(ServicePackagesError(e.toString()));
    }
  }

  Future<void> _onRefreshServicePackages(
    RefreshServicePackages event,
    Emitter<ServicePackagesState> emit,
  ) async {
    try {
      // Get current packages if any
      final currentState = state;
      if (currentState is ServicePackagesLoaded) {
        emit(ServicePackagesLoading());
      }

      // Reuse load logic
      add(LoadServicePackages());
    } catch (e) {
      emit(ServicePackagesError(e.toString()));
    }
  }
}
