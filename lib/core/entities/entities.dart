import 'package:equatable/equatable.dart';

class Citizen extends Equatable {
  final String id;
  final String nik;
  final String name;
  final String email;
  final String phone;
  final String address;
  final DateTime registrationDate;

  const Citizen({
    required this.id,
    required this.nik,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.registrationDate,
  });

  @override
  List<Object> get props =>
      [id, nik, name, email, phone, address, registrationDate];
}

enum ServiceType {
  permit,
  complaint,
  information,
  certificate,
}

enum RequestStatus {
  submitted,
  inReview,
  approved,
  rejected,
  completed,
}

class ServiceRequest extends Equatable {
  final String id;
  final String citizenId;
  final String citizenName;
  final ServiceType serviceType;
  final String title;
  final String description;
  final List<String> attachments;
  final RequestStatus status;
  final DateTime submissionDate;
  final DateTime? reviewDate;
  final DateTime? completionDate;
  final String? adminNotes;
  final String? rejectionReason;

  const ServiceRequest({
    required this.id,
    required this.citizenId,
    required this.citizenName,
    required this.serviceType,
    required this.title,
    required this.description,
    required this.attachments,
    required this.status,
    required this.submissionDate,
    this.reviewDate,
    this.completionDate,
    this.adminNotes,
    this.rejectionReason,
  });

  ServiceRequest copyWith({
    String? id,
    String? citizenId,
    String? citizenName,
    ServiceType? serviceType,
    String? title,
    String? description,
    List<String>? attachments,
    RequestStatus? status,
    DateTime? submissionDate,
    DateTime? reviewDate,
    DateTime? completionDate,
    String? adminNotes,
    String? rejectionReason,
  }) {
    return ServiceRequest(
      id: id ?? this.id,
      citizenId: citizenId ?? this.citizenId,
      citizenName: citizenName ?? this.citizenName,
      serviceType: serviceType ?? this.serviceType,
      title: title ?? this.title,
      description: description ?? this.description,
      attachments: attachments ?? this.attachments,
      status: status ?? this.status,
      submissionDate: submissionDate ?? this.submissionDate,
      reviewDate: reviewDate ?? this.reviewDate,
      completionDate: completionDate ?? this.completionDate,
      adminNotes: adminNotes ?? this.adminNotes,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }

  @override
  List<Object?> get props => [
        id,
        citizenId,
        citizenName,
        serviceType,
        title,
        description,
        attachments,
        status,
        submissionDate,
        reviewDate,
        completionDate,
        adminNotes,
        rejectionReason,
      ];
}

// Admin Entity
class Admin extends Equatable {
  final String id;
  final String username;
  final String name;
  final String email;
  final AdminRole role;

  const Admin({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  List<Object> get props => [id, username, name, email, role];
}

enum AdminRole {
  supervisor,
  operator,
  manager,
}
