import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengajuan_app/core/router/app_router.dart';
import 'package:pengajuan_app/core/theme/app_theme.dart';

import 'core/features/admin/presentation/pages/bloc/admin_bloc.dart';
import 'core/features/auth/presentation/bloc/auth_bloc.dart';
import 'core/features/citizen/presentation/bloc/citizen_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Aplikasi Pengajuan',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
