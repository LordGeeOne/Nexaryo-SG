import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class BlobBackground extends StatefulWidget {
  final Color jointColor;
  final Color background;

  const BlobBackground({
    super.key,
    required this.jointColor,
    required this.background,
  });

  @override
  State<BlobBackground> createState() => _BlobBackgroundState();
}

class _BlobBackgroundState extends State<BlobBackground>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final _notifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      _notifier.value = elapsed.inMilliseconds / 250.0;
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: _BlobAnimation(
        notifier: _notifier,
        jointColor: widget.jointColor,
        background: widget.background,
      ),
    );
  }
}

class _BlobAnimation extends AnimatedWidget {
  final Color jointColor;
  final Color background;

  const _BlobAnimation({
    required ValueNotifier<double> notifier,
    required this.jointColor,
    required this.background,
  }) : super(listenable: notifier);

  @override
  Widget build(BuildContext context) {
    final elapsed = (listenable as ValueNotifier<double>).value;
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _BlobPainter(
            time: elapsed,
            jointColor: jointColor,
            background: background,
          ),
        );
      },
    );
  }
}

class _BlobConfig {
  final double radius;
  final double orbitX;
  final double orbitY;
  final double periodX;
  final double periodY;
  final double phase;
  final double radiusPulse;
  final double pulsePeriod;

  const _BlobConfig({
    required this.radius,
    required this.orbitX,
    required this.orbitY,
    required this.periodX,
    required this.periodY,
    required this.phase,
    required this.radiusPulse,
    required this.pulsePeriod,
  });
}

const _blobs = [
  _BlobConfig(
    radius: 60,
    orbitX: 0.12,
    orbitY: 0.10,
    periodX: 47,
    periodY: 61,
    phase: 0.0,
    radiusPulse: 0.15,
    pulsePeriod: 29,
  ),
  _BlobConfig(
    radius: 45,
    orbitX: 0.18,
    orbitY: 0.14,
    periodX: 37,
    periodY: 53,
    phase: 5.3,
    radiusPulse: 0.20,
    pulsePeriod: 23,
  ),
  _BlobConfig(
    radius: 35,
    orbitX: 0.22,
    orbitY: 0.08,
    periodX: 29,
    periodY: 71,
    phase: 11.7,
    radiusPulse: 0.12,
    pulsePeriod: 41,
  ),
  _BlobConfig(
    radius: 28,
    orbitX: 0.09,
    orbitY: 0.20,
    periodX: 59,
    periodY: 41,
    phase: 19.1,
    radiusPulse: 0.18,
    pulsePeriod: 37,
  ),
  _BlobConfig(
    radius: 50,
    orbitX: 0.15,
    orbitY: 0.16,
    periodX: 43,
    periodY: 67,
    phase: 7.9,
    radiusPulse: 0.14,
    pulsePeriod: 31,
  ),
  _BlobConfig(
    radius: 22,
    orbitX: 0.25,
    orbitY: 0.12,
    periodX: 31,
    periodY: 83,
    phase: 23.4,
    radiusPulse: 0.22,
    pulsePeriod: 19,
  ),
  _BlobConfig(
    radius: 38,
    orbitX: 0.11,
    orbitY: 0.22,
    periodX: 73,
    periodY: 47,
    phase: 3.2,
    radiusPulse: 0.16,
    pulsePeriod: 53,
  ),
  _BlobConfig(
    radius: 55,
    orbitX: 0.14,
    orbitY: 0.13,
    periodX: 67,
    periodY: 37,
    phase: 14.6,
    radiusPulse: 0.13,
    pulsePeriod: 43,
  ),
  _BlobConfig(
    radius: 20,
    orbitX: 0.20,
    orbitY: 0.18,
    periodX: 41,
    periodY: 59,
    phase: 31.5,
    radiusPulse: 0.25,
    pulsePeriod: 17,
  ),
  _BlobConfig(
    radius: 32,
    orbitX: 0.17,
    orbitY: 0.24,
    periodX: 53,
    periodY: 31,
    phase: 26.8,
    radiusPulse: 0.19,
    pulsePeriod: 47,
  ),
];

class _BlobPainter extends CustomPainter {
  final double time;
  final Color jointColor;
  final Color background;

  _BlobPainter({
    required this.time,
    required this.jointColor,
    required this.background,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = background);

    final cx = size.width / 2;
    final cy = size.height / 2;
    final scale = math.min(size.width, size.height) / 500 * 2 * 0.63;

    final paint = Paint()
      ..color = jointColor
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20 * scale);

    // Center blob (gentle pulse)
    final centerR =
        70 * scale * (1.0 + 0.1 * math.sin(2 * math.pi * time / 37));
    canvas.drawCircle(Offset(cx, cy), centerR, paint);

    for (final b in _blobs) {
      final t = time + b.phase;
      final x =
          cx +
          size.width * b.orbitX * 1.44 * math.sin(2 * math.pi * t / b.periodX);
      final y =
          cy +
          size.height * b.orbitY * 1.44 * math.cos(2 * math.pi * t / b.periodY);
      final r =
          b.radius *
          scale *
          (1.0 + b.radiusPulse * math.sin(2 * math.pi * t / b.pulsePeriod));

      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(_BlobPainter old) => old.time != time;
}
