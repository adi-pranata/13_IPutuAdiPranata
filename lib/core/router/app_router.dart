import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pengajuan_app/core/features/citizen/presentation/pages/citizen_registration_page.dart';
import 'package:pengajuan_app/core/features/home/presentation/pages/home_page.dart';

class AppRouter {
  static GoRouter get router => GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/citizen-registration',
            name: 'citizen-registration',
            builder: (context, state) => const CitizenRegistrationPage(),
          ),
          // GoRoute(
          //   path: '/citizen-dashboard',
          //   name: 'citizen-dashboard',
          //   builder: (context, state) => const CitizenDashboardPage(),
          // ),
          // GoRoute(
          //   path: '/service-request',
          //   name: 'service-request',
          //   builder: (context, state) => const ServiceRequestPage(),
          // ),
          // GoRoute(
          //   path: '/admin-login',
          //   name: 'admin-login',
          //   builder: (context, state) => const AdminLoginPage(),
          // ),
          // GoRoute(
          //   path: '/admin-dashboard',
          //   name: 'admin-dashboard',
          //   builder: (context, state) => const AdminDashboardPage(),
          // ),
          // GoRoute(
          //   path: '/verification/:requestId',
          //   name: 'verification',
          //   builder: (context, state) => VerificationPage(
          //     requestId: state.pathParameters['requestId']!,
          //   ),
          // ),
        ],
      );
}
