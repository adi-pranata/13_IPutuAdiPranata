part of 'citizen_bloc.dart';

abstract class CitizenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CitizenInitial extends CitizenState {}

class CitizenLoading extends CitizenState {}

class CitizenRegistered extends CitizenState {
  final Citizen citizen;

  CitizenRegistered({required this.citizen});

  @override
  List<Object> get props => [citizen];
}

class ServiceRequestSuccess extends CitizenState {
  final ServiceRequest request;

  ServiceRequestSuccess({required this.request});

  @override
  List<Object> get props => [request];
}

class CitizenRequestsLoaded extends CitizenState {
  final List<ServiceRequest> requests;

  CitizenRequestsLoaded({required this.requests});

  @override
  List<Object> get props => [requests];
}

class CitizenError extends CitizenState {
  final String message;

  CitizenError({required this.message});

  @override
  List<Object> get props => [message];
}
