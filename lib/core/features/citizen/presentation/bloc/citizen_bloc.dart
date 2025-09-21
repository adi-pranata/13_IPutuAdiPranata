import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../entities/entities.dart';
import '../../domain/usecases/citizen_usecase.dart';

part 'citizen_event.dart';
part 'citizen_state.dart';

class CitizenBloc extends Bloc<CitizenEvent, CitizenState> {
  final RegisterCitizen registerCitizen;
  final SubmitServiceRequest submitServiceRequest;
  final GetCitizenRequests getCitizenRequests;

  CitizenBloc({
    required this.registerCitizen,
    required this.submitServiceRequest,
    required this.getCitizenRequests,
  }) : super(CitizenInitial()) {
    on<CitizenRegisterRequested>(_onRegisterRequested);
    on<ServiceRequestSubmitted>(_onServiceRequestSubmitted);
    on<LoadCitizenRequests>(_onRequestsLoaded);
  }

  Future<void> _onRegisterRequested(
    CitizenRegisterRequested event,
    Emitter<CitizenState> emit,
  ) async {
    emit(CitizenLoading());

    final result = await registerCitizen(RegisterCitizenParams(
      nik: event.nik,
      name: event.name,
      email: event.email,
      phone: event.phone,
      address: event.address,
    ));

    result.fold(
      (failure) => emit(CitizenError(message: failure.toString())),
      (citizen) => emit(CitizenRegistered(citizen: citizen)),
    );
  }

  Future<void> _onServiceRequestSubmitted(
    ServiceRequestSubmitted event,
    Emitter<CitizenState> emit,
  ) async {
    emit(CitizenLoading());

    final result = await submitServiceRequest(SubmitServiceRequestParams(
      citizenId: event.citizenId,
      citizenName: event.citizenName,
      serviceType: event.serviceType,
      title: event.title,
      description: event.description,
      attachments: event.attachments,
    ));

    result.fold(
      (failure) => emit(CitizenError(message: failure.toString())),
      (request) => emit(ServiceRequestSuccess(request: request)),
    );
  }

  Future<void> _onRequestsLoaded(
    LoadCitizenRequests event,
    Emitter<CitizenState> emit,
  ) async {
    emit(CitizenLoading());

    final result = await getCitizenRequests(GetCitizenRequestsParams(
      citizenId: event.citizenId,
    ));

    result.fold(
      (failure) => emit(CitizenError(message: failure.toString())),
      (requests) => emit(CitizenRequestsLoaded(requests: requests)),
    );
  }
}
