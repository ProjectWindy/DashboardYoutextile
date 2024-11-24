part of 'shipping_unit_bloc.dart';

@immutable
sealed class ShippingUnitState {}

final class ShippingUnitInitial extends ShippingUnitState {}

class ShippingUnitLoading extends ShippingUnitState {}
class ShippingUnitSuccess extends ShippingUnitState {}

class ShippingUnitLoaded extends ShippingUnitState {
  final List<ShippingUnit> shippingUnits;
  ShippingUnitLoaded(this.shippingUnits);
}

class ShippingUnitError extends ShippingUnitState {
  final String message;
  ShippingUnitError(this.message);
}