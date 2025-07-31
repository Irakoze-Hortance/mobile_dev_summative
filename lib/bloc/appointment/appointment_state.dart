import 'package:equatable/equatable.dart';
import '../../screens/models/appointment.dart';

class AppointmentState extends Equatable {
  final bool loading;
  final List<Appointment> appointments;
  final String? errorMessage;
  final bool success;

  const AppointmentState({
    this.loading = false,
    this.appointments = const [],
    this.errorMessage,
    this.success = false,
  });

  AppointmentState copyWith({
    bool? loading,
    List<Appointment>? appointments,
    String? errorMessage,
    bool? success,
  }) {
    return AppointmentState(
      loading: loading ?? this.loading,
      appointments: appointments ?? this.appointments,
      errorMessage: errorMessage,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [loading, appointments, errorMessage, success];
}
