import 'package:molfar/core/imports.dart';

class VehicleInfoCard extends StatefulWidget {
  final Vehicle vehicle;
  final VoidCallback onReset;

  const VehicleInfoCard({
    super.key,
    required this.vehicle,
    required this.onReset,
  });

  @override
  State<VehicleInfoCard> createState() => _VehicleInfoCardState();
}

class _VehicleInfoCardState extends State<VehicleInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final double animValue = _pulseController.value;
        final double spreadVal = 1.0 + (animValue * 3.0);
        final double blurVal = 10.0 + (animValue * 10.0);
        final double borderOpacity = 0.5 + (animValue * 0.5);

        return SizedBox(
          key: const ValueKey('ResultContainer'),
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF050A10).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppPalette.secondaryCyan.withOpacity(
                      borderOpacity,
                    ),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppPalette.secondaryCyan.withOpacity(
                        0.3,
                      ),
                      blurRadius: blurVal,
                      spreadRadius: spreadVal,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _ScanlinePainter(
                            repaint: _pulseController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppPalette.secondaryCyan
                                      .withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(
                                  8,
                                ),
                                color: AppPalette.secondaryCyan
                                    .withOpacity(0.05),
                              ),
                              child: Text(
                                widget.vehicle.nRegNew,
                                style: TextStyle(
                                  color: AppPalette.secondaryCyan,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 4.0,
                                  shadows: [
                                    Shadow(
                                      color: AppPalette.secondaryCyan,
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${widget.vehicle.brand} ${widget.vehicle.model}'
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFFD0F5FF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                shadows: [
                                  Shadow(
                                    color: AppPalette.secondaryCyan
                                        .withOpacity(0.5),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            _HoloInfoBlock(
                              title: 'ОСНОВНІ ДАНІ',
                              children: [
                                _HoloInfoRow(
                                  label: 'Рік випуску',
                                  value: '${widget.vehicle.makeYear}',
                                ),
                                _HoloInfoRow(
                                  label: 'Колір',
                                  value: widget.vehicle.color,
                                ),
                                _HoloInfoRow(
                                  label: 'Тип кузова',
                                  value: widget.vehicle.body,
                                ),
                                _HoloInfoRow(
                                  label: 'Призначення',
                                  value: widget.vehicle.kind,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            _HoloInfoBlock(
                              title: 'ТЕХНІЧНІ ХАРАКТЕРИСТИКИ',
                              children: [
                                _HoloInfoRow(
                                  label: 'Паливо',
                                  value: widget.vehicle.fuel,
                                ),
                                _HoloInfoRow(
                                  label: 'Об\'єм двигуна',
                                  value:
                                      '${widget.vehicle.capacity} см³',
                                ),
                                _HoloInfoRow(
                                  label: 'Маса (Власна / Повна)',
                                  value:
                                      '${widget.vehicle.ownWeight} / ${widget.vehicle.totalWeight} кг',
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'VIN CODE',
                                  style: TextStyle(
                                    color: AppPalette.secondaryCyan
                                        .withOpacity(0.7),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppPalette.secondaryCyan
                                        .withOpacity(0.05),
                                    borderRadius:
                                        BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppPalette.secondaryCyan
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    widget.vehicle.vin,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFFD0F5FF),
                                      fontSize: 16,
                                      fontFamily: 'monospace',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      shadows: [
                                        Shadow(
                                          color: AppPalette
                                              .secondaryCyan,
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: double.infinity,
                              height: 68,
                              child: TextButton(
                                onPressed: widget.onReset,
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      AppPalette.secondaryCyan,

                                  backgroundColor: AppPalette
                                      .secondaryCyan
                                      .withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: AppPalette.secondaryCyan
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'НОВИЙ ПОШУК',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: 1.2,
                                    shadows: [
                                      Shadow(
                                        color:
                                            AppPalette.secondaryCyan,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

class _HoloInfoBlock extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _HoloInfoBlock({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppPalette.secondaryCyan,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    color: AppPalette.secondaryCyan,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppPalette.secondaryCyan.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _HoloInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _HoloInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppPalette.secondaryCyan.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: const Color(0xFFD0F5FF),
                fontSize: 15,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: AppPalette.secondaryCyan,
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
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
      paint.color = AppPalette.secondaryCyan.withOpacity(0.03);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);

      if (_random.nextDouble() > 0.98) {
        final double glitchWidth =
            size.width * (0.05 + _random.nextDouble() * 0.15);

        final double startX =
            _random.nextDouble() * (size.width - glitchWidth);

        paint.color = AppPalette.secondaryCyan.withOpacity(0.05);

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
