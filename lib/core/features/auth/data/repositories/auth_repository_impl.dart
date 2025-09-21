import 'package:dartz/dartz.dart';

import '../../../../entities/entities.dart';
import '../../../../error/failures.dart';
import '../../domain/repositories/auth_repositiry.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Admin>> loginAdmin(
      String username, String password) async {
    try {
      final admin = await localDataSource.loginAdmin(username, password);
      return Right(admin);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logoutAdmin() async {
    try {
      await localDataSource.logoutAdmin();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Admin?>> getCurrentSession() async {
    try {
      final admin = await localDataSource.getCurrentSession();
      return Right(admin);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
