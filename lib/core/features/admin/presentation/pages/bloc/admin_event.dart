part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllRequests extends AdminEvent {}

class UpdateRequestStatusEvent extends AdminEvent {
  final String requestId;
  final RequestStatus status;
  final String? adminNotes;
  final String? rejectionReason;

  UpdateRequestStatusEvent({
    required this.requestId,
    required this.status,
    this.adminNotes,
    this.rejectionReason,
  });

  @override
  List<Object?> get props => [requestId, status, adminNotes, rejectionReason];
}

class LoadRequestDetails extends AdminEvent {
  final String requestId;

  LoadRequestDetails({required this.requestId});

  @override
  List<Object?> get props => [requestId];
}
