//Todo Aqui esta la implementacion si se queire usar Rivepod

//import 'package:equatable/equatable.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:qr/config/config.dart';
//import 'package:qr/shared/shared.dart';
//
//final themeNotifierProvider =
//    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
//  return ThemeNotifier();
//});
//
//class ThemeNotifier extends StateNotifier<ThemeState> {
//  ThemeNotifier() : super(ThemeState(isDarkMode: false, selectColor: 26)) {
//    loadThemePreferences();
//  }
//
//  Future<void> loadThemePreferences() async {
//    await Preferences.init();
//    final isDarkMode = Preferences.isDarkMode;
//    final selectColor = Preferences.selectColorInt;
//    state = state.copyWith(isDarkMode: isDarkMode, selectColor: selectColor);
//  }
//
//  Future _saveThemePreferences() async {
//    await Preferences.init();
//    Preferences.isDarkMode = state.isDarkMode;
//    Preferences.selectColorInt = state.selectColor;
//  }
//
//  void changeTheme({int? colorIndex, bool? isDarkMode}) async {
//    state = state.copyWith(
//        isDarkMode: isDarkMode,
//        selectColor: colorIndex,
//        message: "Tema cambiado");
//    // Guardar el cambio en SharedPreferences
//    await _saveThemePreferences();
//  }
//}
//
//class ThemeState extends Equatable {
//  final int selectColor;
//  final bool isDarkMode;
//  final String? message;
//
//  const ThemeState(
//      {required this.isDarkMode, required this.selectColor, this.message})
//      : assert(selectColor >= 0, "El indice de color debe ser mayor a 0"),
//        assert(selectColor < colorsList.length,
//            "El indice de color esta fuera del rango");
//
//  ThemeData getTheme() {
//    return ThemeData(
//      useMaterial3: true,
//      brightness: isDarkMode ? Brightness.dark : Brightness.light,
//      colorSchemeSeed: colorsList[selectColor],
//    );
//  }
//
//  ThemeState copyWith({int? selectColor, bool? isDarkMode, String? message}) =>
//      ThemeState(
//          isDarkMode: isDarkMode ?? this.isDarkMode,
//          message: message ?? this.message,
//          selectColor: selectColor ?? this.selectColor);
//
//  @override
//  List<Object?> get props => [];
//}
