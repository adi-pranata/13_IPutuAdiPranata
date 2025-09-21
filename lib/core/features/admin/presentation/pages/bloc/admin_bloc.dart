import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../entities/entities.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final GetAllRequests getAllRequests;
  final UpdateRequestStatus updateRequestStatus;
  final GetRequestDetails getRequestDetails;

  AdminBloc({
    required this.getAllRequests,
    required this.updateRequestStatus,
    required this.getRequestDetails,
  }) : super(AdminInitial()) {
    on<LoadAllRequests>(_onLoadAllRequests);
    on<UpdateRequestStatusEvent>(_onUpdateRequestStatus);
    on<LoadRequestDetails>(_onLoadRequestDetails);
  }

  Future<void> _onLoadAllRequests(
    LoadAllRequests event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());

    final result = await getAllRequests(NoParams());

    result.fold(
      (failure) => emit(AdminError(message: failure.toString())),
      (requests) => emit(AllRequestsLoaded(requests: requests)),
    );
  }

  Future<void> _onUpdateRequestStatus(
    UpdateRequestStatusEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());

    final result = await updateRequestStatus(UpdateRequestStatusParams(
      requestId: event.requestId,
      status: event.status,
      adminNotes: event.adminNotes,
      rejectionReason: event.rejectionReason,
    ));

    result.fold(
      (failure) => emit(AdminError(message: failure.toString())),
      (request) => emit(RequestStatusUpdated(request: request)),
    );
  }

  Future<void> _onLoadRequestDetails(
    LoadRequestDetails event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());

    final result = await getRequestDetails(GetRequestDetailsParams(
      requestId: event.requestId,
    ));

    result.fold(
      (failure) => emit(AdminError(message: failure.toString())),
      (request) => emit(RequestDetailsLoaded(request: request)),
    );
  }
}
