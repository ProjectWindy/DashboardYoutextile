import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../models/ShippingUnit.dart';
import '../../services/restful_api_provider.dart';
import '../../util/token_manager.dart';

part 'shipping_unit_event.dart';

part 'shipping_unit_state.dart';

class ShippingUnitBloc extends Bloc<ShippingUnitEvent, ShippingUnitState> {
  ShippingUnitBloc() : super(ShippingUnitInitial()) {
    on<FetchShippingUnitEvent>((event, emit) async {
      final RestfulApiProviderImpl restfulApiProviderImpl =
          RestfulApiProviderImpl();

      emit(ShippingUnitLoading());
      try {
        final token = await TokenManager.getToken();

        final units =
            await restfulApiProviderImpl.fetchShippingUnits(token: "$token");
        emit(ShippingUnitLoaded(units));
      } catch (e) {
        emit(ShippingUnitError('Failed to fetch shipping units'));
      }
    });
    on<AddShippingUnitButtonPressed>(_onAddShippingUnitButtonPressed);
    on<UpdateShippingUnitButtonPressed>(_onUpdateShippingUnitButtonPressed);
    on<DeleteShippingUnitButtonPressed>(_onDeleteShippingUnitButtonPressed);
  }

  final RestfulApiProviderImpl _restfulApiProviderImpl =
      RestfulApiProviderImpl();

  Future<void> _onAddShippingUnitButtonPressed(
    AddShippingUnitButtonPressed event,
    Emitter<ShippingUnitState> emit,
  ) async {
    emit(ShippingUnitLoading());

    try {
      await _restfulApiProviderImpl.addShippingUnit(
          name: event.name, status: event.status, img: event.image);

      emit(ShippingUnitSuccess());
    } catch (error) {
      emit(ShippingUnitError(
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
      await _restfulApiProviderImpl.updateShippingUnit(
          uuid: event.uuid,
          name: event.name,
          status: event.status,
          img: event.image);

      emit(ShippingUnitSuccess());
    } catch (error) {
      emit(ShippingUnitError(
        'Có lỗi xảy ra',
      ));
    }
  }

  Future<void> _onDeleteShippingUnitButtonPressed(
    DeleteShippingUnitButtonPressed event,
    Emitter<ShippingUnitState> emit,
  ) async {
    emit(ShippingUnitLoading());

    try {
      await _restfulApiProviderImpl.deleteShippingUnit(
        uuid: event.uuid,
      );

      emit(ShippingUnitSuccess());
    } catch (error) {
      emit(ShippingUnitError(
        'Có lỗi xảy ra',
      ));
    }
  }
}
