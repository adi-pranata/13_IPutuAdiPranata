import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final LoginAdmin loginAdmin;
//   final LogoutAdmin logoutAdmin;
//   final GetCurrentSession getCurrentSession;

//   AuthBloc({
//     required this.loginAdmin,
//     required this.logoutAdmin,
//     required this.getCurrentSession,
//   }) : super(AuthInitial()) {
//     on<AuthLoginRequested>(_onLoginRequested);
//     on<AuthLogoutRequested>(_onLogoutRequested);
//     on<AuthCheckSession>(_onCheckSession);
//   }

//   Future<void> _onLoginRequested(
//     AuthLoginRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());
    
//     final result = await loginAdmin(LoginAdminParams(
//       username: event.username,
//       password: event.password,
//     ));

//     result.fold(
//       (failure) => emit(AuthError(message: failure.toString())),
//       (admin) => emit(AuthAuthenticated(
//         adminId: admin.id,
//         adminName: admin.name,
//       )),
//     );
//   }

//   Future<void> _onLogoutRequested(
//     AuthLogoutRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());
    
//     final result = await logoutAdmin(NoParams());
    
//     result.fold(
//       (failure) => emit(AuthError(message: failure.toString())),
//       (_) => emit(AuthUnauthenticated()),
//     );
//   }

//   Future<void> _onCheckSession(
//     AuthCheckSession event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());
    
//     final result = await getCurrentSession(NoParams());
    
//     result.fold(
//       (failure) => emit(AuthUnauthenticated()),
//       (admin) => admin != null 
//         ? emit(AuthAuthenticated(adminId: admin.id, adminName: admin.name))
//         : emit(AuthUnauthenticated()),
//     );
//   }
// }
