import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? description;

  const SectionHeader({super.key, required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    final ts = context.textStyles;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: ts.heading2),
          if (description != null) ...[
            const SizedBox(height: 6),
            Text(description!, style: ts.bodySecondary),
          ],
        ],
      ),
    );
  }
}
