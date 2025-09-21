import '../../../../entities/entities.dart';
import '../../../../services/local_storage_service.dart';

abstract class AuthLocalDataSource {
  Future<Admin> loginAdmin(String username, String password);
  Future<void> logoutAdmin();
  Future<Admin?> getCurrentSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorageService storageService;

  AuthLocalDataSourceImpl({required this.storageService});
  static const Map<String, Map<String, dynamic>> _demoAdmins = {
    'admin': {
      'id': 'admin-001',
      'username': 'admin',
      'password': 'admin123',
      'name': 'Administrator',
      'email': 'admin@example.com',
      'role': 'supervisor',
    },
    'operator': {
      'id': 'admin-002',
      'username': 'operator',
      'password': 'operator123',
      'name': 'Operator',
      'email': 'operator@example.com',
      'role': 'operator',
    },
  };

  @override
  Future<Admin> loginAdmin(String username, String password) async {
    final adminData = _demoAdmins[username];

    if (adminData == null) {
      throw Exception('Username tidak ditemukan');
    }

    if (adminData['password'] != password) {
      throw Exception('Password salah');
    }

    final admin = Admin(
      id: adminData['id'],
      username: adminData['username'],
      name: adminData['name'],
      email: adminData['email'],
      role: AdminRole.values.firstWhere(
        (role) => role.name == adminData['role'],
      ),
    );

    await storageService.saveAdminSession(admin.id);

    return admin;
  }

  @override
  Future<void> logoutAdmin() async {
    await storageService.clearAdminSession();
  }

  @override
  Future<Admin?> getCurrentSession() async {
    final adminId = await storageService.getAdminSession();

    if (adminId == null) return null;

    for (final entry in _demoAdmins.entries) {
      final adminData = entry.value;
      if (adminData['id'] == adminId) {
        return Admin(
          id: adminData['id'],
          username: adminData['username'],
          name: adminData['name'],
          email: adminData['email'],
          role: AdminRole.values.firstWhere(
            (role) => role.name == adminData['role'],
          ),
        );
      }
    }

    return null;
  }
}
