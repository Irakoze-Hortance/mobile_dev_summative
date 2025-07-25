// appointment_service.dart
// Service for managing appointment CRUD operations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/appointment.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Collection reference for appointments
  CollectionReference get _appointmentsCollection =>
      _firestore.collection('appointments');

  // Create a new appointment
  Future<String> createAppointment(Appointment appointment) async {
    try {
      if (currentUserId == null) {
        throw Exception('User not authenticated');
      }

      final appointmentData = appointment.copyWith(
        userId: currentUserId,
        createdAt: DateTime.now(),
      );

      DocumentReference docRef = await _appointmentsCollection.add(
        appointmentData.toFirestore(),
      );

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }

  // Get all appointments for current user
  Stream<List<Appointment>> getUserAppointments() {
    if (currentUserId == null) {
      return Stream.value([]);
    }

    return _appointmentsCollection
        .where('userId', isEqualTo: currentUserId)
        .orderBy('dateTime', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Appointment.fromFirestore(doc))
          .toList();
    });
  }

  // Get upcoming appointments (next 7 days)
  Stream<List<Appointment>> getUpcomingAppointments() {
    if (currentUserId == null) {
      return Stream.value([]);
    }

    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));

    return _appointmentsCollection
        .where('userId', isEqualTo: currentUserId)
        .where('dateTime', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
        .where('dateTime', isLessThanOrEqualTo: Timestamp.fromDate(nextWeek))
        .orderBy('dateTime', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Appointment.fromFirestore(doc))
          .toList();
    });
  }

  // Update an appointment
  Future<void> updateAppointment(String appointmentId, Appointment appointment) async {
    try {
      if (currentUserId == null) {
        throw Exception('User not authenticated');
      }

      await _appointmentsCollection.doc(appointmentId).update(
        appointment.toFirestore(),
      );
    } catch (e) {
      throw Exception('Failed to update appointment: $e');
    }
  }

  // Delete an appointment
  Future<void> deleteAppointment(String appointmentId) async {
    try {
      if (currentUserId == null) {
        throw Exception('User not authenticated');
      }

      await _appointmentsCollection.doc(appointmentId).delete();
    } catch (e) {
      throw Exception('Failed to delete appointment: $e');
    }
  }

  // Get a single appointment by ID
  Future<Appointment?> getAppointment(String appointmentId) async {
    try {
      if (currentUserId == null) {
        throw Exception('User not authenticated');
      }

      DocumentSnapshot doc = await _appointmentsCollection.doc(appointmentId).get();
      
      if (doc.exists && doc.data() != null) {
        final appointment = Appointment.fromFirestore(doc);
        // Verify the appointment belongs to the current user
        if (appointment.userId == currentUserId) {
          return appointment;
        }
      }
      
      return null;
    } catch (e) {
      throw Exception('Failed to get appointment: $e');
    }
  }

  // Get appointment count for current user
  Future<int> getAppointmentCount() async {
    try {
      if (currentUserId == null) {
        return 0;
      }

      QuerySnapshot snapshot = await _appointmentsCollection
          .where('userId', isEqualTo: currentUserId)
          .get();

      return snapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }
}
