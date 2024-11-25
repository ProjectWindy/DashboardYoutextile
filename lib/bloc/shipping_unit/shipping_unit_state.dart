part of 'shipping_unit_bloc.dart';

@immutable
sealed class ShippingUnitState extends Equatable {
  const ShippingUnitState();
  
  @override
  List<Object> get props => [];
}

final class ShippingUnitInitial extends ShippingUnitState {}

class ShippingUnitLoading extends ShippingUnitState {}
class ShippingUnitSuccess extends ShippingUnitState {
  final String message;

  const ShippingUnitSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ShippingUnitLoaded extends ShippingUnitState {
  final List<ShippingUnit> shippingUnits;

  const ShippingUnitLoaded(this.shippingUnits);

  @override
  List<Object> get props => [shippingUnits];
}

class ShippingUnitError extends ShippingUnitState {
  final String message;

  const ShippingUnitError(this.message);

  @override
  List<Object> get props => [message];
}