import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment_state.dart';
import '../../screens/models/appointment.dart';
import '../../services/appointment_service.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentService _appointmentService = AppointmentService();

  AppointmentCubit() : super(const AppointmentState());

  // Load existing appointments
  Future<void> fetchAppointments() async {
    emit(state.copyWith(loading: true, errorMessage: null));
    try {
      final appointments = await _appointmentService.fetchAppointments();
      emit(state.copyWith(loading: false, appointments: appointments));
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }

  // Create a new appointment
  Future<void> createAppointment(Appointment appointment) async {
    emit(state.copyWith(loading: true, success: false, errorMessage: null));
    try {
      await _appointmentService.createAppointment(appointment);
      // Refresh list after adding
      final updatedAppointments = List<Appointment>.from(state.appointments)
        ..add(appointment);
      emit(state.copyWith(
        loading: false,
        appointments: updatedAppointments,
        success: true,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }
}
