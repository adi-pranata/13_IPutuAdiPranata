import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../entities/entities.dart';
import '../../../../error/failures.dart';
import '../../../../usescases/base_usecase.dart';
import '../repositories/auth_repositiry.dart';

class LoginAdmin implements UseCase<Admin, LoginAdminParams> {
  final AuthRepository repository;

  LoginAdmin(this.repository);

  @override
  Future<Either<Failure, Admin>> call(LoginAdminParams params) async {
    return await repository.loginAdmin(params.username, params.password);
  }
}

class LoginAdminParams extends Equatable {
  final String username;
  final String password;

  const LoginAdminParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

// Logout Admin UseCase
class LogoutAdmin implements UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutAdmin(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logoutAdmin();
  }
}

// Get Current Session UseCase
class GetCurrentSession implements UseCase<Admin?, NoParams> {
  final AuthRepository repository;

  GetCurrentSession(this.repository);

  @override
  Future<Either<Failure, Admin?>> call(NoParams params) async {
    return await repository.getCurrentSession();
  }
}
