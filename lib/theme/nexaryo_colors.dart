import 'package:flutter/material.dart';

class NexaryoColors extends ThemeExtension<NexaryoColors> {
  final Color background;
  final Color surface;
  final Color card;
  final Color cardBorder;
  final Color primary;
  final Color accentWarm;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDim;

  const NexaryoColors({
    required this.background,
    required this.surface,
    required this.card,
    required this.cardBorder,
    required this.primary,
    required this.accentWarm,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDim,
  });

  static const defaults = NexaryoColors(
    background: Color(0xFF151515),
    surface: Color(0xFF1A1A1A),
    card: Color(0xFF1E1E1E),
    cardBorder: Color(0xFF2A2A2A),
    primary: Color(0xFF6C63FF),
    accentWarm: Color(0xFFFF8A65),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB0B0B0),
    textDim: Color(0xFF808080),
  );

  @override
  NexaryoColors copyWith({
    Color? background,
    Color? surface,
    Color? card,
    Color? cardBorder,
    Color? primary,
    Color? accentWarm,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDim,
  }) {
    return NexaryoColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      cardBorder: cardBorder ?? this.cardBorder,
      primary: primary ?? this.primary,
      accentWarm: accentWarm ?? this.accentWarm,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDim: textDim ?? this.textDim,
    );
  }

  @override
  NexaryoColors lerp(NexaryoColors? other, double t) {
    if (other == null) return this;
    return NexaryoColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      accentWarm: Color.lerp(accentWarm, other.accentWarm, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textDim: Color.lerp(textDim, other.textDim, t)!,
    );
  }

  /// All color entries as a list for iteration.
  List<NexaryoColorEntry> get entries => [
    NexaryoColorEntry('background', 'Background', background),
    NexaryoColorEntry('surface', 'Surface', surface),
    NexaryoColorEntry('card', 'Card', card),
    NexaryoColorEntry('cardBorder', 'Card Border', cardBorder),
    NexaryoColorEntry('primary', 'Primary', primary),
    NexaryoColorEntry('accentWarm', 'Accent Warm', accentWarm),
    NexaryoColorEntry('textPrimary', 'Text Primary', textPrimary),
    NexaryoColorEntry('textSecondary', 'Text Secondary', textSecondary),
    NexaryoColorEntry('textDim', 'Text Dim', textDim),
  ];

  /// Built-in theme palettes.
  static const List<NexaryoPalette> palettes = [
    NexaryoPalette(
      id: 'nexaryo',
      name: 'Nexaryo',
      accent: Color(0xFF6C63FF),
      dark: NexaryoColors(
        background: Color(0xFF151515),
        surface: Color(0xFF1A1A1A),
        card: Color(0xFF1E1E1E),
        cardBorder: Color(0xFF2A2A2A),
        primary: Color(0xFF6C63FF),
        accentWarm: Color(0xFFFF8A65),
        textPrimary: Color(0xFFFFFFFF),
        textSecondary: Color(0xFFB0B0B0),
        textDim: Color(0xFF808080),
      ),
      light: NexaryoColors(
        background: Color(0xFFF5F5F5),
        surface: Color(0xFFFFFFFF),
        card: Color(0xFFFFFFFF),
        cardBorder: Color(0xFFE0E0E0),
        primary: Color(0xFF6C63FF),
        accentWarm: Color(0xFFFF8A65),
        textPrimary: Color(0xFF111111),
        textSecondary: Color(0xFF555555),
        textDim: Color(0xFF888888),
      ),
    ),
    NexaryoPalette(
      id: 'ember',
      name: 'Ember',
      accent: Color(0xFFFF6B35),
      dark: NexaryoColors(
        background: Color(0xFF130D09),
        surface: Color(0xFF1C1410),
        card: Color(0xFF221810),
        cardBorder: Color(0xFF36261A),
        primary: Color(0xFFFF6B35),
        accentWarm: Color(0xFFFFB347),
        textPrimary: Color(0xFFFFF0E8),
        textSecondary: Color(0xFFBFA090),
        textDim: Color(0xFF7A5A4A),
      ),
      light: NexaryoColors(
        background: Color(0xFFFFF7F2),
        surface: Color(0xFFFFFFFF),
        card: Color(0xFFFFFFFF),
        cardBorder: Color(0xFFEEDDD4),
        primary: Color(0xFFD44A1A),
        accentWarm: Color(0xFFE07000),
        textPrimary: Color(0xFF1A0800),
        textSecondary: Color(0xFF5A3020),
        textDim: Color(0xFF9A7060),
      ),
    ),
    NexaryoPalette(
      id: 'ocean',
      name: 'Ocean',
      accent: Color(0xFF00B0FF),
      dark: NexaryoColors(
        background: Color(0xFF060F16),
        surface: Color(0xFF0C1A24),
        card: Color(0xFF101E2A),
        cardBorder: Color(0xFF1A3040),
        primary: Color(0xFF00B0FF),
        accentWarm: Color(0xFF26C6DA),
        textPrimary: Color(0xFFE8F4FF),
        textSecondary: Color(0xFF7AB0C8),
        textDim: Color(0xFF3D687E),
      ),
      light: NexaryoColors(
        background: Color(0xFFF0F8FF),
        surface: Color(0xFFFFFFFF),
        card: Color(0xFFFFFFFF),
        cardBorder: Color(0xFFCCDDEE),
        primary: Color(0xFF0080C0),
        accentWarm: Color(0xFF008899),
        textPrimary: Color(0xFF00141E),
        textSecondary: Color(0xFF2A5A7A),
        textDim: Color(0xFF6A9AB0),
      ),
    ),
  ];
}

class NexaryoColorEntry {
  final String key;
  final String label;
  final Color color;
  const NexaryoColorEntry(this.key, this.label, this.color);
}

class NexaryoPalette {
  final String id;
  final String name;
  final Color accent;
  final NexaryoColors dark;
  final NexaryoColors light;
  const NexaryoPalette({
    required this.id,
    required this.name,
    required this.accent,
    required this.dark,
    required this.light,
  });
}

extension NexaryoThemeX on BuildContext {
  NexaryoColors get colors => Theme.of(this).extension<NexaryoColors>()!;
}

extension ColorHex on Color {
  String get hexCode {
    final rv = (r * 255).round().toRadixString(16).padLeft(2, '0');
    final gv = (g * 255).round().toRadixString(16).padLeft(2, '0');
    final bv = (b * 255).round().toRadixString(16).padLeft(2, '0');
    return '#$rv$gv$bv'.toUpperCase();
  }

  int get argbInt =>
      ((a * 255).round() << 24) |
      ((r * 255).round() << 16) |
      ((g * 255).round() << 8) |
      (b * 255).round();
}
