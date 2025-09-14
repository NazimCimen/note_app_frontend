import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_layout_state.dart';

/// Cubit for managing app layout navigation state
class AppLayoutCubit extends Cubit<AppLayoutState> {
  AppLayoutCubit() : super(const AppLayoutState.initial());

  /// Change the current navigation index
  void changeTab(int index) {
    if (index >= 0 && index < 2) {
      emit(AppLayoutState.tabChanged(index));
    }
  }

  /// Navigate to home tab
  void goToHome() {
    emit(const AppLayoutState.tabChanged(0));
  }

  /// Navigate to profile tab
  void goToProfile() {
    emit(const AppLayoutState.tabChanged(1));
  }
}
