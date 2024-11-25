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
    on<CreateServicePackage>(_onCreateServicePackage);
    on<UpdateServicePackage>(_onUpdateServicePackage);
    on<DeleteServicePackage>(_onDeleteServicePackage);
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

  Future<void> _onCreateServicePackage(
    CreateServicePackage event,
    Emitter<ServicePackagesState> emit,
  ) async {
    try {
      emit(ServicePackagesLoading());

      var token = await TokenManager.getToken();
      token ??= '3|abJ70ndnOBiNoxMCKunklCkQZUUHgqXT8umVQ7xW908f9b79';

      final packageData = {
        'name': event.name,
        'short_description': event.shortDescription,
        'description': event.description,
        'original_price': event.originalPrice.toString(),
        'duration': event.duration,
        'is_option': event.isOption,
      };

      final response = await apiProvider.createServicePackage(
        token: token,
        packageData: packageData,
      );

      // Reload packages after creating new one
      add(LoadServicePackages());

      // Emit success state với message
      emit(ServicePackagesSuccess(response.data['message']));
    } catch (error) {
      emit(ServicePackagesError(error.toString()));
    }
  }

  Future<void> _onUpdateServicePackage(
    UpdateServicePackage event,
    Emitter<ServicePackagesState> emit,
  ) async {
    try {
      emit(ServicePackagesLoading());

      var token = await TokenManager.getToken();
      token ??= '3|abJ70ndnOBiNoxMCKunklCkQZUUHgqXT8umVQ7xW908f9b79';

      final packageData = {
        'name': event.name,
        'short_description': event.shortDescription,
        'description': event.description,
        'original_price': event.originalPrice.toString(),
        'duration': event.duration,
        'is_option': event.isOption,
        'status': event.status,
        'discount_price': (event.discountPrice ?? 0).toString(),
      };

      final response = await apiProvider.updateServicePackage(
        token: token,
        uuid: event.uuid,
        packageData: packageData,
      );

      // Reload packages after updating
      add(LoadServicePackages());

      // Emit success state với message
      emit(ServicePackagesSuccess(response.data['message']));
    } catch (error) {
      emit(ServicePackagesError(error.toString()));
    }
  }

  Future<void> _onDeleteServicePackage(
    DeleteServicePackage event,
    Emitter<ServicePackagesState> emit,
  ) async {
    try {
      emit(ServicePackagesLoading());

      var token = await TokenManager.getToken();
      token ??= '3|abJ70ndnOBiNoxMCKunklCkQZUUHgqXT8umVQ7xW908f9b79';

      final response = await apiProvider.deleteServicePackage(
        token: token,
        uuid: event.uuid,
      );

      // Reload packages after deleting
      add(LoadServicePackages());

      // Emit success state với message
      emit(ServicePackagesSuccess(response.data['message']));
    } catch (error) {
      emit(ServicePackagesError(error.toString()));
    }
  }
}
