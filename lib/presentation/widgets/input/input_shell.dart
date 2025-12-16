import 'package:molfar/core/imports.dart';

class CyberInputShell extends StatefulWidget {
  final FocusNode focusNode;
  final double height;
  final Widget child;

  const CyberInputShell({
    super.key,
    required this.focusNode,
    required this.height,
    required this.child,
  });

  @override
  State<CyberInputShell> createState() => _CyberInputShellState();
}

class _CyberInputShellState extends State<CyberInputShell>
    with SingleTickerProviderStateMixin {
  bool _isFocused = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChanged);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      lowerBound: 0.6,
      upperBound: 1.0,
    );
  }

  void _onFocusChanged() {
    setState(() {
      _isFocused = widget.focusNode.hasFocus;
      if (_isFocused) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double borderRadiusValue = 16.0;
    const double borderWidth = 1.0;

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final double glowOpacity = _isFocused
            ? _pulseController.value
            : 0.0;

        final List<Color> borderColors = _isFocused
            ? [
                AppPalette.primaryYellow,
                AppPalette.secondaryCyan,
                AppPalette.primaryYellow,
              ]
            : [
                AppPalette.secondaryCyan.withOpacity(0.3),
                AppPalette.secondaryCyan.withOpacity(0.3),
              ];

        return Container(
          height: widget.height,
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            boxShadow: [
              BoxShadow(
                color: AppPalette.primaryYellow.withOpacity(
                  glowOpacity * 0.4,
                ),
                blurRadius: 25,
                spreadRadius: 0,
              ),
              if (!_isFocused)
                BoxShadow(
                  color: AppPalette.secondaryCyan.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: -2,
                ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    borderRadiusValue,
                  ),
                  border: Border.all(
                    color: AppPalette.secondaryCyan.withAlpha(125),
                    width: borderWidth,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: borderColors,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(borderWidth),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    borderRadiusValue - borderWidth,
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _ScanlinePainter(
                            repaint: _pulseController,
                          ),
                        ),
                      ),
                      widget.child,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
      paint.color = Colors.white.withOpacity(0.01);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);

      if (_random.nextDouble() > 0.99) {
        final double glitchWidth =
            size.width * (0.05 + _random.nextDouble() * 0.15);

        final double startX =
            _random.nextDouble() * (size.width - glitchWidth);

        paint.color = Colors.white.withOpacity(0.08);

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
