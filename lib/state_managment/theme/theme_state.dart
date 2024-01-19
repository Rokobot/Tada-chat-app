part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class CurrentThemeState extends ThemeState{
  final bool themeIs;

  CurrentThemeState({required this.themeIs});
  @override
  List<Object?> get props => [themeIs];
}
