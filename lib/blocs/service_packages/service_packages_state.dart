import 'package:equatable/equatable.dart';
import 'package:ipad_dashboard/models/service_package.dart';

abstract class ServicePackagesState extends Equatable {
  const ServicePackagesState();
  
  @override
  List<Object> get props => [];
}

class ServicePackagesInitial extends ServicePackagesState {}

class ServicePackagesLoading extends ServicePackagesState {}

class ServicePackagesLoaded extends ServicePackagesState {
  final List<ServicePackage> packages;

  const ServicePackagesLoaded(this.packages);

  @override
  List<Object> get props => [packages];
}

class ServicePackagesError extends ServicePackagesState {
  final String message;

  const ServicePackagesError(this.message);

  @override
  List<Object> get props => [message];
} 