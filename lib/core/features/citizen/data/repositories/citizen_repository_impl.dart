import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../../../../entities/entities.dart';
import '../../../../error/failures.dart';
import '../../../../services/local_storage_service.dart';
import '../../domain/repositories/citizen_repository.dart';

class CitizenRepositoryImpl implements CitizenRepository {
  final CitizenLocalDataSource localDataSource;

  CitizenRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Citizen>> registerCitizen({
    required String nik,
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    try {
      final citizen = await localDataSource.registerCitizen(
        nik: nik,
        name: name,
        email: email,
        phone: phone,
        address: address,
      );
      return Right(citizen);
    } catch (e) {
      return Left(ValidationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceRequest>> submitServiceRequest({
    required String citizenId,
    required String citizenName,
    required ServiceType serviceType,
    required String title,
    required String description,
    required List<String> attachments,
  }) async {
    try {
      final request = await localDataSource.submitServiceRequest(
        citizenId: citizenId,
        citizenName: citizenName,
        serviceType: serviceType,
        title: title,
        description: description,
        attachments: attachments,
      );
      return Right(request);
    } catch (e) {
      return Left(ValidationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ServiceRequest>>> getCitizenRequests(
      String citizenId) async {
    try {
      final requests = await localDataSource.getCitizenRequests(citizenId);
      return Right(requests);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Citizen?>> getCitizen(String citizenId) async {
    try {
      final citizen = await localDataSource.getCitizen(citizenId);
      return Right(citizen);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

abstract class CitizenLocalDataSource {
  Future<Citizen> registerCitizen({
    required String nik,
    required String name,
    required String email,
    required String phone,
    required String address,
  });

  Future<ServiceRequest> submitServiceRequest({
    required String citizenId,
    required String citizenName,
    required ServiceType serviceType,
    required String title,
    required String description,
    required List<String> attachments,
  });

  Future<List<ServiceRequest>> getCitizenRequests(String citizenId);
  Future<Citizen?> getCitizen(String citizenId);
}

class CitizenLocalDataSourceImpl implements CitizenLocalDataSource {
  final LocalStorageService storageService;
  final Uuid uuid = const Uuid();

  CitizenLocalDataSourceImpl({required this.storageService});

  @override
  Future<Citizen> registerCitizen({
    required String nik,
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    final existingCitizens = await storageService.getAllCitizens();
    final existingCitizen =
        existingCitizens.where((c) => c.nik == nik).firstOrNull;

    if (existingCitizen != null) {
      throw Exception('NIK sudah terdaftar');
    }

    final citizen = Citizen(
      id: uuid.v4(),
      nik: nik,
      name: name,
      email: email,
      phone: phone,
      address: address,
      registrationDate: DateTime.now(),
    );

    await storageService.saveCitizen(citizen);
    await storageService.saveCurrentCitizenId(citizen.id);

    return citizen;
  }

  @override
  Future<ServiceRequest> submitServiceRequest({
    required String citizenId,
    required String citizenName,
    required ServiceType serviceType,
    required String title,
    required String description,
    required List<String> attachments,
  }) async {
    final request = ServiceRequest(
      id: uuid.v4(),
      citizenId: citizenId,
      citizenName: citizenName,
      serviceType: serviceType,
      title: title,
      description: description,
      attachments: attachments,
      status: RequestStatus.submitted,
      submissionDate: DateTime.now(),
    );

    await storageService.saveServiceRequest(request);

    return request;
  }

  @override
  Future<List<ServiceRequest>> getCitizenRequests(String citizenId) async {
    return await storageService.getServiceRequestsByCitizen(citizenId);
  }

  @override
  Future<Citizen?> getCitizen(String citizenId) async {
    return await storageService.getCitizen(citizenId);
  }
}
