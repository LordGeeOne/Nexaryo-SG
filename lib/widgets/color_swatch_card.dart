import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/nexaryo_colors.dart';

class ColorSwatchCard extends StatelessWidget {
  final String name;
  final Color color;
  final String hexCode;
  final String usage;

  const ColorSwatchCard({
    super.key,
    required this.name,
    required this.color,
    required this.hexCode,
    required this.usage,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final isLight = color.computeLuminance() > 0.5;
    return Container(
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(33),
              ),
            ),
            child: Center(
              child: Text(
                hexCode,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isLight ? Colors.black87 : Colors.white70,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  usage,
                  style: GoogleFonts.montserrat(fontSize: 12, color: c.textDim),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
