part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}


class ChangeThemeEvent extends ThemeEvent{
  final bool themeValue;

  ChangeThemeEvent({required this.themeValue});
  @override
  List<Object?> get props => [themeValue];
}