import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const Color _black = Color(0xFF000000);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _ink = Color(0xFF0A0A0A); 
  static const Color _elevated = Color(0xFF161616);
  static const Color _mutedLight = Color(0xFF6B6B6B);
  static const Color _mutedDark = Color(0xFFA0A0A0);
  static const Color _hairlineLight = Color(0xFFE8E8E8);
  static const Color _hairlineDark = Color(0xFF2A2A2A);
  static const Color _canvasLight = Color(0xFFF6F6F6);

  static const double _radius = 12;

  static ThemeData get light => _build(
        brightness: Brightness.light,
        onColor: _black,
        surface: _white,
        canvas: _canvasLight,
        muted: _mutedLight,
        hairline: _hairlineLight,
        inverse: _black,
        onInverse: _white,
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        onColor: _white,
        surface: _ink,
        canvas: _black,
        muted: _mutedDark,
        hairline: _hairlineDark,
        inverse: _white,
        onInverse: _black,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color onColor, 
    required Color surface,
    required Color canvas, 
    required Color muted,
    required Color hairline,
    required Color inverse,
    required Color onInverse, 
  }) {
    final isDark = brightness == Brightness.dark;

    final scheme = ColorScheme(
      brightness: brightness,
      primary: onColor,
      onPrimary: isDark ? _black : _white,
      secondary: muted,
      onSecondary: isDark ? _black : _white,
      surface: surface,
      onSurface: onColor,
      surfaceContainerHighest: isDark ? _elevated : _canvasLight,
      onSurfaceVariant: muted,
      outline: hairline,
      outlineVariant: hairline,
      error: const Color(0xFFD8261C),
      onError: _white,
      inverseSurface: inverse,
      onInverseSurface: onInverse,
    );

    final baseText = isDark
        ? Typography.material2021().white
        : Typography.material2021().black;

    final textTheme = baseText
        .apply(fontFamilyFallback: const ['SF Pro Display', 'Roboto'])
        .copyWith(
          displaySmall: _t(34, FontWeight.w700, onColor, -0.5),
          headlineMedium: _t(28, FontWeight.w700, onColor, -0.4),
          headlineSmall: _t(24, FontWeight.w700, onColor, -0.3),
          titleLarge: _t(20, FontWeight.w700, onColor, -0.2),
          titleMedium: _t(16, FontWeight.w600, onColor, -0.1),
          bodyLarge: _t(16, FontWeight.w400, onColor, 0),
          bodyMedium: _t(14, FontWeight.w400, muted, 0),
          labelLarge: _t(15, FontWeight.w600, onColor, 0),
          labelMedium: _t(12, FontWeight.w600, muted, 0.4),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: canvas,
      splashFactory: InkSparkle.splashFactory,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: canvas,
        surfaceTintColor: Colors.transparent,
        foregroundColor: onColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: _t(20, FontWeight.w700, onColor, -0.2),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: BorderSide(color: hairline),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: hairline,
        thickness: 1,
        space: 1,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: inverse,
          foregroundColor: onInverse,
          disabledBackgroundColor: hairline,
          disabledForegroundColor: muted,
          minimumSize: const Size.fromHeight(54),
          elevation: 0,
          textStyle: _t(16, FontWeight.w600, onInverse, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: onColor,
          minimumSize: const Size.fromHeight(54),
          side: BorderSide(color: onColor, width: 1.5),
          textStyle: _t(16, FontWeight.w600, onColor, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: onColor,
          textStyle: _t(15, FontWeight.w600, onColor, 0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? _elevated : _canvasLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        hintStyle: _t(16, FontWeight.w400, muted, 0),
        labelStyle: _t(16, FontWeight.w400, muted, 0),
        floatingLabelStyle: _t(14, FontWeight.w600, onColor, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: hairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: onColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: onColor,
        linearTrackColor: hairline,
        circularTrackColor: hairline,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: onColor,
        textColor: onColor,
      ),
    );
  }

  static TextStyle _t(
    double size,
    FontWeight weight,
    Color color,
    double spacing,
  ) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: spacing,
      height: 1.2,
    );
  }
}
