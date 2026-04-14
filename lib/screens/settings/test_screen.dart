import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../theme/nexaryo_colors.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  static const _fonts = [
    'Montserrat',
    'ZTOtez',
    'Uniwars',
    'Talero',
    'Miloner',
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Container(
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: IconButton(
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowLeft01,
                        color: c.textDim,
                        size: 24,
                      ),
                      iconSize: 24,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Font Test',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: c.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Font list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _fonts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, i) {
                  final family = _fonts[i];
                  final isGoogle = family == 'Montserrat';
                  final style = isGoogle
                      ? GoogleFonts.montserrat(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: c.textPrimary,
                        )
                      : TextStyle(
                          fontFamily: family,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: c.textPrimary,
                        );

                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: c.card,
                      borderRadius: BorderRadius.circular(34),
                      border: Border.all(color: c.cardBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          family,
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: c.textDim,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text('NEXARYO', style: style),
                        const SizedBox(height: 4),
                        Text('Lumora', style: style),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
