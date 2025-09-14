part of 'app_layout_cubit.dart';

/// App layout state for navigation management
sealed class AppLayoutState extends Equatable {
  const AppLayoutState();

  const factory AppLayoutState.initial() = AppLayoutInitial;
  const factory AppLayoutState.tabChanged(int currentIndex) = AppLayoutTabChanged;

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial state
final class AppLayoutInitial extends AppLayoutState {
  const AppLayoutInitial();
}

/// Tab changed state
final class AppLayoutTabChanged extends AppLayoutState {
  final int currentIndex;
  
  const AppLayoutTabChanged(this.currentIndex);

  @override
  List<Object?> get props => <Object?>[currentIndex];
}
