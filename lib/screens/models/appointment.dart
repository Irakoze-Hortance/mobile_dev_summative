
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String? id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String doctorName;
  final String location;
  final String userId;
  final DateTime createdAt;

  Appointment({
    this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.doctorName,
    required this.location,
    required this.userId,
    required this.createdAt,
  });

  // Convert from Firestore document
  factory Appointment.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Appointment(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      doctorName: data['doctorName'] ?? '',
      location: data['location'] ?? '',
      userId: data['userId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert to map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'dateTime': Timestamp.fromDate(dateTime),
      'doctorName': doctorName,
      'location': location,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Copy with method for updates
  Appointment copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
    String? doctorName,
    String? location,
    String? userId,
    DateTime? createdAt,
  }) {
    return Appointment(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      doctorName: doctorName ?? this.doctorName,
      location: location ?? this.location,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
