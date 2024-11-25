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
