import 'package:equatable/equatable.dart';

abstract class ServicePackagesEvent extends Equatable {
  const ServicePackagesEvent();

  @override
  List<Object> get props => [];
}

class LoadServicePackages extends ServicePackagesEvent {
  final int? page;

  LoadServicePackages({this.page});
}

class RefreshServicePackages extends ServicePackagesEvent {}

class CreateServicePackage extends ServicePackagesEvent {
  final String name;
  final String shortDescription;
  final String description;
  final double originalPrice;
  final int duration;
  final bool isOption;

  CreateServicePackage({
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.originalPrice,
    required this.duration,
    required this.isOption,
  });

  @override
  List<Object> get props =>
      [name, shortDescription, description, originalPrice, duration, isOption];
}

class UpdateServicePackage extends ServicePackagesEvent {
  final String uuid;
  final String name;
  final String shortDescription;
  final String description;
  final double originalPrice;
  final int duration;
  final bool isOption;
  final String status;
  final double? discountPrice;

  double get finalDiscountPrice => discountPrice ?? 0;

  UpdateServicePackage({
    required this.uuid,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.originalPrice,
    required this.duration,
    required this.isOption,
    required this.status,
    this.discountPrice,
  });

  @override
  List<Object> get props => [
        uuid,
        name,
        shortDescription,
        description,
        originalPrice,
        duration,
        isOption,
        status,
        finalDiscountPrice
      ];
}

class DeleteServicePackage extends ServicePackagesEvent {
  final String uuid;

  const DeleteServicePackage({required this.uuid});

  @override
  List<Object> get props => [uuid];
}
