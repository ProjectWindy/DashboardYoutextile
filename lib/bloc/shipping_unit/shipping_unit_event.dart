part of 'shipping_unit_bloc.dart';

@immutable
sealed class ShippingUnitEvent {}

class FetchShippingUnitEvent extends ShippingUnitEvent {}

class AddShippingUnitButtonPressed extends ShippingUnitEvent {
  final MultipartFile image;
  final String name;
  final String status;

  AddShippingUnitButtonPressed({required this.image, required this.name,required this.status});
}
class UpdateShippingUnitButtonPressed extends ShippingUnitEvent {
  final String uuid;
  final MultipartFile image;
  final String name;
  final String status;

  UpdateShippingUnitButtonPressed({required this.uuid,required this.image, required this.name,required this.status});
}
class DeleteShippingUnitButtonPressed extends ShippingUnitEvent {
  final String uuid;

  DeleteShippingUnitButtonPressed({required this.uuid});
}
