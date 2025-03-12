part of 'theme_bloc.dart';

// Estado
class ThemeState extends Equatable {
  final int selectColor;
  final bool isDarkMode;
  final String? message;

  const ThemeState(
      {required this.isDarkMode, required this.selectColor, this.message})
      : assert(selectColor >= 0, "El índice de color debe ser mayor a 0"),
        assert(selectColor < colorsList.length,
            "El índice de color está fuera del rango");

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colorsList[selectColor],
    );
  }

  ThemeState copyWith({int? selectColor, bool? isDarkMode, String? message}) =>
      ThemeState(
        isDarkMode: isDarkMode ?? this.isDarkMode,
        selectColor: selectColor ?? this.selectColor,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [selectColor, isDarkMode, message];
}
