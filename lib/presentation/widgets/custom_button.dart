import 'package:molfar/core/imports.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.isLoading = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _glitchController;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _glitchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double height = 68.0;
    const double borderRadiusValue = 16.0;

    Widget buttonContent = Container(
      height: height,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusValue),
        color: AppPalette.surface.withOpacity(0.6),
        border: widget.isLoading
            ? null
            : Border.all(
                color: AppPalette.primaryYellow.withOpacity(0.5),
                width: 1.0,
              ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadiusValue),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _ScanlinePainter(repaint: _glitchController),
              ),
            ),

            Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: widget.isLoading ? 0.0 : 1.0,
                child: Text(
                  widget.text.toUpperCase(),
                  style: GoogleFonts.orbitron(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: AppPalette.primaryYellow,
                    shadows: [
                      Shadow(
                        color: AppPalette.primaryYellow.withOpacity(
                          0.6,
                        ),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (widget.isLoading) {
      return ZoDualBorder(
        firstBorderColor: AppPalette.primaryYellow,
        secondBorderColor: AppPalette.secondaryCyan,
        trackBorderColor: AppPalette.secondaryCyan.withOpacity(0.1),
        borderWidth: 4.0,
        glowOpacity: 0.3,
        animationDuration: const Duration(seconds: 2),
        borderRadius: BorderRadius.circular(borderRadiusValue),
        child: buttonContent,
      );
    } else {
      return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ZoAnimatedGradientBorder(
            borderRadius: borderRadiusValue,
            borderThickness: 1.0,
            animationDuration: const Duration(seconds: 5),
            glowOpacity: 0.2,
            gradientColor: const [
              AppPalette.primaryYellow,
              AppPalette.secondaryCyan,
              AppPalette.primaryYellow,
            ],
            child: buttonContent,
          ),
        ),
      );
    }
  }
}

class _ScanlinePainter extends CustomPainter {
  final Animation<double> repaint;
  final Random _random = Random();

  _ScanlinePainter({required this.repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (double y = 0; y < size.height; y += 4) {
      paint.color = AppPalette.primaryYellow.withOpacity(0.05);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);

      if (_random.nextDouble() > 0.99) {
        final double glitchWidth =
            size.width * (0.05 + _random.nextDouble() * 0.15);
        final double startX =
            _random.nextDouble() * (size.width - glitchWidth);
        paint.color = AppPalette.primaryYellow.withOpacity(0.1);

        canvas.drawLine(
          Offset(startX, y),
          Offset(startX + glitchWidth, y),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ScanlinePainter oldDelegate) => true;
}
