part of 'shipping_unit_bloc.dart';

@immutable
sealed class ShippingUnitEvent {}

class FetchShippingUnitEvent extends ShippingUnitEvent {}

class AddShippingUnitButtonPressed extends ShippingUnitEvent {
  final String name;
  final String status;
  final String description;
  final MultipartFile image;

  AddShippingUnitButtonPressed({
    required this.name,
    required this.status,
    required this.description,
    required this.image,
  });
}

class UpdateShippingUnitButtonPressed extends ShippingUnitEvent {
  final String uuid;
  final MultipartFile image;
  final String name;
  final String status;

  UpdateShippingUnitButtonPressed(
      {required this.uuid,
      required this.image,
      required this.name,
      required this.status});
}

class DeleteShippingUnitButtonPressed extends ShippingUnitEvent {
  final String uuid;

  DeleteShippingUnitButtonPressed({required this.uuid});
}

class DeleteShippingUnitEvent extends ShippingUnitEvent {
  final String uuid;

  DeleteShippingUnitEvent({required this.uuid});

  @override
  List<Object> get props => [uuid];
}
