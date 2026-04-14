import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../theme/nexaryo_colors.dart';

class StyleGuideHome extends StatelessWidget {
  final Function(int) onNavigate;

  const StyleGuideHome({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Nexaryo',
            style: TextStyle(
              fontFamily: 'Miloner',
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          Text(
            'Style Guide',
            style: GoogleFonts.montserrat(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: c.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'The canonical design reference and development framework for all Nexaryo applications.',
            style: GoogleFonts.montserrat(
              fontSize: 15,
              height: 1.5,
              color: c.textSecondary,
            ),
          ),
          const SizedBox(height: 32),

          // Design Tokens
          _groupLabel(context, 'Design Tokens'),
          const SizedBox(height: 10),
          _sectionCard(
            context,
            icon: HugeIcons.strokeRoundedPaintBoard,
            title: 'Colors',
            description: 'The shared dark color palette',
            index: 1,
          ),
          _sectionCard(
            context,
            icon: HugeIcons.strokeRoundedTextFont,
            title: 'Typography',
            description: 'Montserrat type scale & weights',
            index: 2,
          ),
          _sectionCard(
            context,
            icon: HugeIcons.strokeRoundedSmile,
            title: 'Icons',
            description: 'HugeIcons stroke-rounded icon sets',
            index: 3,
          ),
          _sectionCard(
            context,
            icon: HugeIcons.strokeRoundedAlignTop,
            title: 'Spacing',
            description: 'Spacing scale & border radii',
            index: 7,
          ),
          const SizedBox(height: 24),

          // Components
          _groupLabel(context, 'Components'),
          const SizedBox(height: 10),
          _sectionCard(
            context,
            icon: HugeIcons.strokeRoundedTouchInteraction01,
            title: 'Buttons',
            description: 'Button variants & states',
            index: 4,
          ),
          _sectionCard(
            context,
            icon: HugeIcons.strokeRoundedCrop,
            title: 'Cards',
            description: 'Card components & layouts',
            index: 5,
          ),
          _sectionCard(
            context,
            icon: HugeIcons.strokeRoundedInputText,
            title: 'Inputs',
            description: 'Fields, sliders, toggles',
            index: 6,
          ),
          const SizedBox(height: 24),

          // Framework
          _groupLabel(context, 'Framework'),
          const SizedBox(height: 10),
          _sectionCard(
            context,
            icon: HugeIcons.strokeRoundedFolder01,
            title: 'File Structure',
            description: 'Standard project layout & organization',
            index: 8,
          ),
          _sectionCard(
            context,
            icon: HugeIcons.strokeRoundedTag01,
            title: 'Naming Conventions',
            description: 'Files, classes, variables, widgets',
            index: 9,
          ),
          _sectionCard(
            context,
            icon: HugeIcons.strokeRoundedGridView,
            title: 'Patterns',
            description: 'One-handed mode, state, navigation',
            index: 10,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _groupLabel(BuildContext context, String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: context.colors.textDim,
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required List<List<dynamic>> icon,
    required String title,
    required String description,
    required int index,
  }) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: c.card,
        borderRadius: BorderRadius.circular(34),
        child: InkWell(
          onTap: () => onNavigate(index),
          borderRadius: BorderRadius.circular(34),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              border: Border.all(color: c.cardBorder),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: c.cardBorder,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: Center(
                    child: HugeIcon(
                      icon: icon,
                      color: c.textSecondary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: c.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: c.textDim,
                        ),
                      ),
                    ],
                  ),
                ),
                HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowRight01,
                  color: c.textDim,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
