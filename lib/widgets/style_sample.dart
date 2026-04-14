import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/nexaryo_colors.dart';

class StyleSample extends StatelessWidget {
  final String name;
  final TextStyle style;
  final String sampleText;

  const StyleSample({
    super.key,
    required this.name,
    required this.style,
    this.sampleText = 'The quick brown fox jumps over the lazy dog',
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: c.primary,
                ),
              ),
              const Spacer(),
              Text(
                '${style.fontSize?.toInt()}px · w${style.fontWeight?.value ?? 400}',
                style: GoogleFonts.montserrat(fontSize: 12, color: c.textDim),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(sampleText, style: style),
        ],
      ),
    );
  }
}
