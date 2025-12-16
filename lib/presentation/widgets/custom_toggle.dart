import 'package:molfar/core/imports.dart';

class CustomToggle extends StatefulWidget {
  final SearchMode currentMode;
  final Function(SearchMode) onModeChanged;

  const CustomToggle({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle>
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
    const double padding = 4.0;
    const double borderRadiusValue = 16.0;

    return Container(
      height: height,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: AppPalette.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(borderRadiusValue),
        border: Border.all(
          color: AppPalette.secondaryCyan.withOpacity(0.5),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(padding),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                borderRadiusValue - padding,
              ),
              child: CustomPaint(
                painter: _ScanlinePainter(repaint: _glitchController),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: widget.currentMode == SearchMode.plate
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth / 2,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppPalette.secondaryCyan.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppPalette.secondaryCyan.withOpacity(0.6),
                        blurRadius: 12,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Row(
            children: [
              Expanded(
                child: _ToggleButton(
                  title: 'НОМЕРА',
                  isActive: widget.currentMode == SearchMode.plate,
                  onTap: () => widget.onModeChanged(SearchMode.plate),
                ),
              ),
              Expanded(
                child: _ToggleButton(
                  title: 'ВІН КОД',
                  isActive: widget.currentMode == SearchMode.vin,
                  onTap: () => widget.onModeChanged(SearchMode.vin),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: GoogleFonts.orbitron(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
            color: isActive ? Colors.black : AppPalette.secondaryCyan,
            shadows: isActive
                ? []
                : [
                    Shadow(
                      color: AppPalette.secondaryCyan.withOpacity(0.6),
                      blurRadius: 4,
                    ),
                  ],
          ),
          child: Text(title),
        ),
      ),
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
      
      paint.color = Colors.white.withOpacity(0.02);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);

      if (_random.nextDouble() > 0.99) {
        final double glitchWidth = size.width * (0.05 + _random.nextDouble() * 0.15);

        final double startX = _random.nextDouble() * (size.width - glitchWidth);

        paint.color = Colors.white.withOpacity(0.05);
        
        canvas.drawLine(
          Offset(startX, y), 
          Offset(startX + glitchWidth, y), 
          paint
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ScanlinePainter oldDelegate) => true;
}