import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../entities/entities.dart';
import '../../../../error/failures.dart';
import '../../../../usescases/base_usecase.dart';
import '../repositories/citizen_repository.dart';

// Register Citizen UseCase
class RegisterCitizen implements UseCase<Citizen, RegisterCitizenParams> {
  final CitizenRepository repository;

  RegisterCitizen(this.repository);

  @override
  Future<Either<Failure, Citizen>> call(RegisterCitizenParams params) async {
    return await repository.registerCitizen(
      nik: params.nik,
      name: params.name,
      email: params.email,
      phone: params.phone,
      address: params.address,
    );
  }
}

class RegisterCitizenParams extends Equatable {
  final String nik;
  final String name;
  final String email;
  final String phone;
  final String address;

  const RegisterCitizenParams({
    required this.nik,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  @override
  List<Object> get props => [nik, name, email, phone, address];
}

// Submit Service Request UseCase
class SubmitServiceRequest
    implements UseCase<ServiceRequest, SubmitServiceRequestParams> {
  final CitizenRepository repository;

  SubmitServiceRequest(this.repository);

  @override
  Future<Either<Failure, ServiceRequest>> call(
      SubmitServiceRequestParams params) async {
    return await repository.submitServiceRequest(
      citizenId: params.citizenId,
      citizenName: params.citizenName,
      serviceType: params.serviceType,
      title: params.title,
      description: params.description,
      attachments: params.attachments,
    );
  }
}

class SubmitServiceRequestParams extends Equatable {
  final String citizenId;
  final String citizenName;
  final ServiceType serviceType;
  final String title;
  final String description;
  final List<String> attachments;

  const SubmitServiceRequestParams({
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

// Get Citizen Requests UseCase
class GetCitizenRequests
    implements UseCase<List<ServiceRequest>, GetCitizenRequestsParams> {
  final CitizenRepository repository;

  GetCitizenRequests(this.repository);

  @override
  Future<Either<Failure, List<ServiceRequest>>> call(
      GetCitizenRequestsParams params) async {
    return await repository.getCitizenRequests(params.citizenId);
  }
}

class GetCitizenRequestsParams extends Equatable {
  final String citizenId;

  const GetCitizenRequestsParams({required this.citizenId});

  @override
  List<Object> get props => [citizenId];
}
