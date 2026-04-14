import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'nexaryo_colors.dart';

class AppTextStyles {
  final NexaryoColors _colors;
  AppTextStyles(this._colors);

  // Headings
  TextStyle get heading1 => GoogleFonts.montserrat(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: _colors.textPrimary,
  );

  TextStyle get heading2 => GoogleFonts.montserrat(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: _colors.textPrimary,
  );

  TextStyle get heading3 => GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: _colors.textPrimary,
  );

  // Body
  TextStyle get bodyLarge => GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _colors.textPrimary,
  );

  TextStyle get body => GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _colors.textPrimary,
  );

  TextStyle get bodySecondary => GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _colors.textSecondary,
  );

  // Labels & Captions
  TextStyle get label => GoogleFonts.montserrat(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: _colors.textSecondary,
  );

  TextStyle get caption => GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: _colors.textDim,
  );

  // Buttons
  TextStyle get button => GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: _colors.textPrimary,
  );

  // App Bar
  TextStyle get appBarTitle => GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: _colors.textPrimary,
  );
}

extension NexaryoTextStylesX on BuildContext {
  AppTextStyles get textStyles => AppTextStyles(colors);
}
