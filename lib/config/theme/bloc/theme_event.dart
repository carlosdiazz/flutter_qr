part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object?> get props => [];
}

// Evento para cambiar el tema
class ChangeThemeEvent extends ThemeEvent {
  final int? colorIndex;
  final bool? isDarkMode;
  const ChangeThemeEvent({this.colorIndex, this.isDarkMode});
}
