import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/appointment/appointment_cubit.dart';
import '../bloc/appointment/appointment_state.dart';
import 'models/appointment.dart';

class AppointmentFormScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  AppointmentFormScreen({super.key, Appointment? appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Appointment')),
      body: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Appointment created successfully')),
            );
            Navigator.pop(context);
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Appointment Name'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                const SizedBox(height: 20),
                if (state.loading) const CircularProgressIndicator(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state.loading
                      ? null
                      : () {
                          final appointment = Appointment(
  name: nameController.text,
  title: '',
  description: '',
  dateTime: DateTime.parse(dateController.text), // or use a date picker instead
  doctorName: '',
  location: '',
  userId: 'someUserId', // get this from auth or context
  createdAt: DateTime.now(),
);

                          context.read<AppointmentCubit>().createAppointment(appointment);
                        },
                  child: const Text('Create Appointment'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
