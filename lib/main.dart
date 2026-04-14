import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'providers/theme_provider.dart';
import 'theme/nexaryo_colors.dart';
import 'screens/dashboard_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsProvider();
  final themeProvider = ThemeProvider();
  await Future.wait([settings.load(), themeProvider.load()]);
  runApp(NexaryoStyleGuide(settings: settings, themeProvider: themeProvider));
}

class NexaryoStyleGuide extends StatelessWidget {
  final SettingsProvider settings;
  final ThemeProvider themeProvider;

  const NexaryoStyleGuide({
    super.key,
    required this.settings,
    required this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            title: 'Nexaryo SG',
            debugShowCheckedModeBanner: false,
            theme: _buildThemeData(theme.lightColors, Brightness.light),
            darkTheme: _buildThemeData(theme.darkColors, Brightness.dark),
            themeMode: theme.themeMode,
            home: const _SplashEntry(),
          );
        },
      ),
    );
  }
}

ThemeData _buildThemeData(NexaryoColors c, Brightness brightness) {
  final base = brightness == Brightness.dark
      ? ThemeData.dark()
      : ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: c.background,
    extensions: [c],
    appBarTheme: AppBarTheme(
      backgroundColor: c.background,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: c.textPrimary,
      ),
      iconTheme: IconThemeData(color: c.textPrimary),
    ),
    textTheme: GoogleFonts.montserratTextTheme(base.textTheme),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: c.primary,
      foregroundColor: Colors.white,
    ),
  );
}

class _SplashEntry extends StatelessWidget {
  const _SplashEntry();

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      onFinished: () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => const DashboardScreen(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
    );
  }
}
