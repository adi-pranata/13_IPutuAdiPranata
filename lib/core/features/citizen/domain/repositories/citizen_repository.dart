import 'package:dartz/dartz.dart';

import '../../../../entities/entities.dart';
import '../../../../error/failures.dart';

abstract class CitizenRepository {
  Future<Either<Failure, Citizen>> registerCitizen({
    required String nik,
    required String name,
    required String email,
    required String phone,
    required String address,
  });

  Future<Either<Failure, ServiceRequest>> submitServiceRequest({
    required String citizenId,
    required String citizenName,
    required ServiceType serviceType,
    required String title,
    required String description,
    required List<String> attachments,
  });

  Future<Either<Failure, List<ServiceRequest>>> getCitizenRequests(
      String citizenId);
  Future<Either<Failure, Citizen?>> getCitizen(String citizenId);
}
