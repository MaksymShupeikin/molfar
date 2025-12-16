import 'package:molfar/core/imports.dart';

class MolfarLogo extends StatelessWidget {
  final double size;

  const MolfarLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppPalette.primaryYellow.withAlpha(50),
                blurRadius: size / 2,
                spreadRadius: -size / 4,
              ),
            ],
          ),
          child: CustomPaint(painter: _SparkPainter()),
        ),
        SizedBox(width: 16),
        Text(
          "MOLFAR",
          style: GoogleFonts.orbitron(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 20.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _SparkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);

    final linePaint = Paint()
      ..color = AppPalette.secondaryCyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = h * 0.12
      ..strokeCap = StrokeCap.round;

    final lineGlowPaint = Paint()
      ..color = AppPalette.secondaryCyan.withAlpha(150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = h * 0.25
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final sparkPaint = Paint()
      ..color = AppPalette.primaryYellow
      ..style = PaintingStyle.fill;

    final sparkGlowPaint = Paint()
      ..color = AppPalette.primaryYellow.withAlpha(165)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    final leftLineStart = Offset(0, h / 2);
    final leftLineEnd = Offset(w * 0.35, h / 2);
    final rightLineStart = Offset(w * 0.65, h / 2);
    final rightLineEnd = Offset(w, h / 2);

    canvas.drawLine(leftLineStart, leftLineEnd, lineGlowPaint);
    canvas.drawLine(rightLineStart, rightLineEnd, lineGlowPaint);
    canvas.drawLine(leftLineStart, leftLineEnd, linePaint);
    canvas.drawLine(rightLineStart, rightLineEnd, linePaint);

    final sparkPath = Path()
      ..moveTo(center.dx, h * 0.2)
      ..lineTo(w * 0.8, center.dy)
      ..lineTo(center.dx, h * 0.8)
      ..lineTo(w * 0.2, center.dy)
      ..close();

    canvas.drawPath(sparkPath, sparkGlowPaint);
    canvas.drawPath(sparkPath, sparkPaint..color = Colors.white);
    canvas.drawPath(
      sparkPath,
      sparkPaint
        ..color = AppPalette.primaryYellow
        ..style = PaintingStyle.stroke
        ..strokeWidth = h * 0.05,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
