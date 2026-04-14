import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../theme/nexaryo_colors.dart';
import '../widgets/blob_background.dart';
import 'settings/settings_screen.dart';
import 'style_guide_home.dart';
import 'colors_section.dart';
import 'typography_section.dart';
import 'icons_section.dart';
import 'buttons_section.dart';
import 'cards_section.dart';
import 'inputs_section.dart';
import 'spacing_section.dart';
import 'file_structure_section.dart';
import 'naming_conventions_section.dart';
import 'patterns_section.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  static const _sections = [
    _Section('Nexaryo SG', null),
    _Section('Colors', null),
    _Section('Typography', null),
    _Section('Icons', null),
    _Section('Buttons', null),
    _Section('Cards', null),
    _Section('Inputs', null),
    _Section('Spacing', null),
    _Section('File Structure', null),
    _Section('Naming', null),
    _Section('Patterns', null),
  ];

  // Back panel top content is roughly 120px (safe area + app name + subtitle).
  // We reserve that by capping maxChildSize so the front panel can't fully cover it.
  static const double _minSheet = 0.5;
  static const double _maxSheet = 0.82;
  static const double _initialSheet = 0.5;

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  void _navigate(int index) {
    setState(() => _currentIndex = index);
    // Snap front panel up when entering a section
    if (index != 0 && _sheetController.isAttached) {
      _sheetController.animateTo(
        _maxSheet,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  void _navigateHome() {
    setState(() => _currentIndex = 0);
    if (_sheetController.isAttached) {
      _sheetController.animateTo(
        _initialSheet,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      body: Stack(
        children: [
          // Background color fills full screen behind front panel
          Container(color: c.background),
          // ── Back Panel ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: BlobBackground(
              jointColor: c.primary,
              background: c.background,
            ),
          ),
          // Glass overlay
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.black.withOpacity(0.25)),
            ),
          ),
          _buildBackPanel(context),

          // ── Front Panel ──
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: _initialSheet,
            minChildSize: _minSheet,
            maxChildSize: _maxSheet,
            snap: true,
            snapSizes: const [_initialSheet, _maxSheet],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: c.card,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(34),
                  ),
                ),
                child: Column(
                  children: [
                    // Drag handle
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 6),
                      child: Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: c.cardBorder,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Section title bar (inside front panel)
                    if (_currentIndex != 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Container(
                              height: 68,
                              width: 68,
                              decoration: BoxDecoration(
                                color: c.card,
                                borderRadius: BorderRadius.circular(34),
                              ),
                              child: IconButton(
                                icon: HugeIcon(
                                  icon: HugeIcons.strokeRoundedArrowLeft01,
                                  color: c.textDim,
                                  size: 24,
                                ),
                                iconSize: 24,
                                onPressed: _navigateHome,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _sections[_currentIndex].title,
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: c.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Content
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        children: [
                          _buildCurrentPage(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ── Back Panel ──
  Widget _buildBackPanel(BuildContext context) {
    final c = context.colors;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: app name + settings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nexaryo',
                  style: TextStyle(
                    fontFamily: 'Miloner',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                Container(
                  height: 68,
                  width: 68,
                  decoration: BoxDecoration(
                    color: c.card,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: IconButton(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedSettings01,
                      color: c.textDim,
                      size: 24,
                    ),
                    iconSize: 24,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Style Guide',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: c.textDim,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Content Router ──
  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return StyleGuideHome(onNavigate: _navigate);
      case 1:
        return const ColorsSection();
      case 2:
        return const TypographySection();
      case 3:
        return const IconsSection();
      case 4:
        return const ButtonsSection();
      case 5:
        return const CardsSection();
      case 6:
        return InputsSection();
      case 7:
        return const SpacingSection();
      case 8:
        return const FileStructureSection();
      case 9:
        return const NamingConventionsSection();
      case 10:
        return const PatternsSection();
      default:
        return const SizedBox.shrink();
    }
  }
}

class _Section {
  final String title;
  final dynamic icon;
  const _Section(this.title, this.icon);
}
