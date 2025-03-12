import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr/config/config.dart';
import 'package:qr/shared/shared.dart';

part 'theme_event.dart';
part 'theme_state.dart';

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(isDarkMode: false, selectColor: 26)) {
    on<ChangeThemeEvent>(_onChangeTheme);
    _loadThemePreferences();
  }

  void _onChangeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) async {
    final newState = state.copyWith(
      isDarkMode: event.isDarkMode ?? state.isDarkMode,
      selectColor: event.colorIndex ?? state.selectColor,
      message: "Tema cambiado",
    );
    emit(newState);
    await _saveThemePreferences(newState);
  }

  Future<void> _loadThemePreferences() async {
    await Preferences.init();
    final isDarkMode = Preferences.isDarkMode;
    final selectColor = Preferences.selectColorInt;
    add(ChangeThemeEvent(colorIndex: selectColor, isDarkMode: isDarkMode));
  }

  Future<void> _saveThemePreferences(ThemeState state) async {
    await Preferences.init();
    Preferences.isDarkMode = state.isDarkMode;
    Preferences.selectColorInt = state.selectColor;
  }
}
