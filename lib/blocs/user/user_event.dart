import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserDetails extends UserEvent {
  final String uuid;

  const LoadUserDetails(this.uuid);

  @override
  List<Object> get props => [uuid];
} 