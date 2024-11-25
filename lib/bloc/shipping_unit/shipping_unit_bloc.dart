import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/ShippingUnit.dart';
import '../../services/restful_api_provider.dart';
import '../../util/token_manager.dart';

part 'shipping_unit_event.dart';

part 'shipping_unit_state.dart';

class ShippingUnitBloc extends Bloc<ShippingUnitEvent, ShippingUnitState> {
  final RestfulApiProviderImpl apiProvider;

  ShippingUnitBloc({required this.apiProvider}) : super(ShippingUnitInitial()) {
    on<FetchShippingUnitEvent>((event, emit) async {
      emit(ShippingUnitLoading());
      try {
        // final token = await TokenManager.getToken();
        var token = await TokenManager.getToken();

        // Gán token mặc định nếu null
        token ??= '3|abJ70ndnOBiNoxMCKunklCkQZUUHgqXT8umVQ7xW908f9b79';
        final units = await apiProvider.fetchShippingUnits(token: "$token");
        emit(ShippingUnitLoaded(units));
      } catch (e) {
        emit(ShippingUnitError('Failed to fetch shipping units'));
      }
    });
    on<AddShippingUnitButtonPressed>(_onAddShippingUnitButtonPressed);
    on<UpdateShippingUnitButtonPressed>(_onUpdateShippingUnitButtonPressed);
    on<DeleteShippingUnitEvent>((event, emit) async {
      try {
        emit(ShippingUnitLoading());
        var token = await TokenManager.getToken();
        token ??= '3|abJ70ndnOBiNoxMCKunklCkQZUUHgqXT8umVQ7xW908f9b79';

         await apiProvider.deleteShippingUnit(uuid: event.uuid, token: token);

        // Emit success message
        emit(ShippingUnitSuccess('Xóa đơn vị vận chuyển thành công'));

        // Trigger fetch event để reload data
        add(FetchShippingUnitEvent());
      } catch (e) {
        emit(ShippingUnitError(
            'Lỗi khi xóa đơn vị vận chuyển: ${e.toString()}'));
      }
    });
  }

  Future<void> _onAddShippingUnitButtonPressed(
    AddShippingUnitButtonPressed event,
    Emitter<ShippingUnitState> emit,
  ) async {
    emit(ShippingUnitLoading());

    try {
      var token = await TokenManager.getToken();

      // Gán token mặc định nếu null
      token ??= '3|abJ70ndnOBiNoxMCKunklCkQZUUHgqXT8umVQ7xW908f9b79';
      await apiProvider.addShippingUnit(
          name: event.name, status: event.status, img: event.image);

      emit(ShippingUnitSuccess('Thêm đơn vị vận chuyển thành công'));
    } catch (error) {
      emit(const ShippingUnitError(
        'Có lỗi xảy ra',
      ));
    }
  }

  Future<void> _onUpdateShippingUnitButtonPressed(
    UpdateShippingUnitButtonPressed event,
    Emitter<ShippingUnitState> emit,
  ) async {
    emit(ShippingUnitLoading());

    try {
      await apiProvider.updateShippingUnit(
          uuid: event.uuid,
          name: event.name,
          status: event.status,
          img: event.image);

      emit(ShippingUnitSuccess('Cập nhật đơn vị vận chuyển thành công'));
    } catch (error) {
      emit(const ShippingUnitError(
        'Có lỗi xảy ra',
      ));
    }
  }
}
