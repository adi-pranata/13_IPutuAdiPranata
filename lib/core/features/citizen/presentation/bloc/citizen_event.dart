part of 'citizen_bloc.dart';

abstract class CitizenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CitizenRegisterRequested extends CitizenEvent {
  final String nik;
  final String name;
  final String email;
  final String phone;
  final String address;

  CitizenRegisterRequested({
    required this.nik,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  @override
  List<Object> get props => [nik, name, email, phone, address];
}

class ServiceRequestSubmitted extends CitizenEvent {
  final String citizenId;
  final String citizenName;
  final ServiceType serviceType;
  final String title;
  final String description;
  final List<String> attachments;

  ServiceRequestSubmitted({
    required this.citizenId,
    required this.citizenName,
    required this.serviceType,
    required this.title,
    required this.description,
    required this.attachments,
  });

  @override
  List<Object> get props =>
      [citizenId, citizenName, serviceType, title, description, attachments];
}

class LoadCitizenRequests extends CitizenEvent {
  final String citizenId;

  LoadCitizenRequests({required this.citizenId});

  @override
  List<Object> get props => [citizenId];
}
