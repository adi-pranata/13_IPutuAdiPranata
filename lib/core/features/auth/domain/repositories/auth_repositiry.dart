import 'package:dartz/dartz.dart';

import '../../../../entities/entities.dart';
import '../../../../error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Admin>> loginAdmin(String username, String password);
  Future<Either<Failure, void>> logoutAdmin();
  Future<Either<Failure, Admin?>> getCurrentSession();
}
