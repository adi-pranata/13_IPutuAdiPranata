import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/entities.dart';

abstract class LocalStorageService {
  Future<void> saveCitizen(Citizen citizen);
  Future<Citizen?> getCitizen(String id);
  Future<List<Citizen>> getAllCitizens();

  Future<void> saveServiceRequest(ServiceRequest request);
  Future<ServiceRequest?> getServiceRequest(String id);
  Future<List<ServiceRequest>> getAllServiceRequests();
  Future<List<ServiceRequest>> getServiceRequestsByCitizen(String citizenId);
  Future<void> updateServiceRequest(ServiceRequest request);

  Future<void> saveCurrentCitizenId(String citizenId);
  Future<String?> getCurrentCitizenId();
  Future<void> clearCurrentCitizenId();

  Future<void> saveAdminSession(String adminId);
  Future<String?> getAdminSession();
  Future<void> clearAdminSession();
}

class LocalStorageServiceImpl implements LocalStorageService {
  static const String _citizensKey = 'citizens';
  static const String _serviceRequestsKey = 'service_requests';
  static const String _currentCitizenKey = 'current_citizen_id';
  static const String _adminSessionKey = 'admin_session';

  @override
  Future<void> saveCitizen(Citizen citizen) async {
    final prefs = await SharedPreferences.getInstance();
    final citizens = await getAllCitizens();

    // Remove existing citizen with same ID if any
    citizens.removeWhere((c) => c.id == citizen.id);
    citizens.add(citizen);

    final citizensJson = citizens.map((c) => _citizenToJson(c)).toList();
    await prefs.setString(_citizensKey, jsonEncode(citizensJson));
  }

  @override
  Future<Citizen?> getCitizen(String id) async {
    final citizens = await getAllCitizens();
    try {
      return citizens.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Citizen>> getAllCitizens() async {
    final prefs = await SharedPreferences.getInstance();
    final citizensString = prefs.getString(_citizensKey);

    if (citizensString == null) return [];

    final List<dynamic> citizensJson = jsonDecode(citizensString);
    return citizensJson.map((json) => _citizenFromJson(json)).toList();
  }

  @override
  Future<void> saveServiceRequest(ServiceRequest request) async {
    final prefs = await SharedPreferences.getInstance();
    final requests = await getAllServiceRequests();

    // Remove existing request with same ID if any
    requests.removeWhere((r) => r.id == request.id);
    requests.add(request);

    final requestsJson = requests.map((r) => _serviceRequestToJson(r)).toList();
    await prefs.setString(_serviceRequestsKey, jsonEncode(requestsJson));
  }

  @override
  Future<ServiceRequest?> getServiceRequest(String id) async {
    final requests = await getAllServiceRequests();
    try {
      return requests.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ServiceRequest>> getAllServiceRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final requestsString = prefs.getString(_serviceRequestsKey);

    if (requestsString == null) return [];

    final List<dynamic> requestsJson = jsonDecode(requestsString);
    return requestsJson.map((json) => _serviceRequestFromJson(json)).toList();
  }

  @override
  Future<List<ServiceRequest>> getServiceRequestsByCitizen(
      String citizenId) async {
    final allRequests = await getAllServiceRequests();
    return allRequests.where((r) => r.citizenId == citizenId).toList();
  }

  @override
  Future<void> updateServiceRequest(ServiceRequest request) async {
    await saveServiceRequest(request);
  }

  @override
  Future<void> saveCurrentCitizenId(String citizenId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentCitizenKey, citizenId);
  }

  @override
  Future<String?> getCurrentCitizenId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentCitizenKey);
  }

  @override
  Future<void> clearCurrentCitizenId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentCitizenKey);
  }

  @override
  Future<void> saveAdminSession(String adminId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_adminSessionKey, adminId);
  }

  @override
  Future<String?> getAdminSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_adminSessionKey);
  }

  @override
  Future<void> clearAdminSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_adminSessionKey);
  }

  // Helper methods for JSON conversion
  Map<String, dynamic> _citizenToJson(Citizen citizen) => {
        'id': citizen.id,
        'nik': citizen.nik,
        'name': citizen.name,
        'email': citizen.email,
        'phone': citizen.phone,
        'address': citizen.address,
        'registrationDate': citizen.registrationDate.toIso8601String(),
      };

  Citizen _citizenFromJson(Map<String, dynamic> json) => Citizen(
        id: json['id'],
        nik: json['nik'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        registrationDate: DateTime.parse(json['registrationDate']),
      );

  Map<String, dynamic> _serviceRequestToJson(ServiceRequest request) => {
        'id': request.id,
        'citizenId': request.citizenId,
        'citizenName': request.citizenName,
        'serviceType': request.serviceType.name,
        'title': request.title,
        'description': request.description,
        'attachments': request.attachments,
        'status': request.status.name,
        'submissionDate': request.submissionDate.toIso8601String(),
        'reviewDate': request.reviewDate?.toIso8601String(),
        'completionDate': request.completionDate?.toIso8601String(),
        'adminNotes': request.adminNotes,
        'rejectionReason': request.rejectionReason,
      };

  ServiceRequest _serviceRequestFromJson(Map<String, dynamic> json) =>
      ServiceRequest(
        id: json['id'],
        citizenId: json['citizenId'],
        citizenName: json['citizenName'],
        serviceType:
            ServiceType.values.firstWhere((e) => e.name == json['serviceType']),
        title: json['title'],
        description: json['description'],
        attachments: List<String>.from(json['attachments'] ?? []),
        status:
            RequestStatus.values.firstWhere((e) => e.name == json['status']),
        submissionDate: DateTime.parse(json['submissionDate']),
        reviewDate: json['reviewDate'] != null
            ? DateTime.parse(json['reviewDate'])
            : null,
        completionDate: json['completionDate'] != null
            ? DateTime.parse(json['completionDate'])
            : null,
        adminNotes: json['adminNotes'],
        rejectionReason: json['rejectionReason'],
      );
}
