// splash_bloc.dart
// BLoC for handling splash screen logic
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
    on<SplashFinished>(_onSplashFinished);
  }

  void _onSplashStarted(SplashStarted event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    
    // Simulate some initialization time (e.g., checking auth state, loading data)
    await Future.delayed(const Duration(seconds: 2));
    
    add(SplashFinished());
  }

  void _onSplashFinished(SplashFinished event, Emitter<SplashState> emit) {
    emit(SplashCompleted());
  }
}
