// splash_event.dart
// Events for splash screen BLoC
import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class SplashStarted extends SplashEvent {}

class SplashFinished extends SplashEvent {}
