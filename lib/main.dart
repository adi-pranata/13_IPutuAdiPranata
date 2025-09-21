import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengajuan_app/core/router/app_router.dart';
import 'package:pengajuan_app/core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<AuthBloc>(
        //   create: (_) => di.sl<AuthBloc>(),
        // ),
        // BlocProvider<CitizenBloc>(
        //   create: (_) => di.sl<CitizenBloc>(),
        // ),
        // BlocProvider<AdminBloc>(
        //   create: (_) => di.sl<AdminBloc>(),
        // ),
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
