part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AllRequestsLoaded extends AdminState {
  final List<ServiceRequest> requests;

  AllRequestsLoaded({required this.requests});

  @override
  List<Object> get props => [requests];
}

class RequestDetailsLoaded extends AdminState {
  final ServiceRequest request;

  RequestDetailsLoaded({required this.request});

  @override
  List<Object> get props => [request];
}

class RequestStatusUpdated extends AdminState {
  final ServiceRequest request;

  RequestStatusUpdated({required this.request});

  @override
  List<Object> get props => [request];
}

class AdminError extends AdminState {
  final String message;

  AdminError({required this.message});

  @override
  List<Object> get props => [message];
}
