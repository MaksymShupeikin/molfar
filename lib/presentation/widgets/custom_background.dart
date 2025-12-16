import 'package:molfar/core/imports.dart';

class CustomBackground extends StatefulWidget {
  final Widget child;

  const CustomBackground({super.key, required this.child});

  @override
  State<CustomBackground> createState() => _CustomBackgroundState();
}

class _CustomBackgroundState extends State<CustomBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  void _initParticles(Size size) {
    if (_particles.isNotEmpty) return;
    for (int i = 0; i < 30; i++) {
      _particles.add(
        Particle(
          position: Offset(
            _random.nextDouble() * size.width,
            _random.nextDouble() * size.height,
          ),
          velocity: Offset(
            (_random.nextDouble() - 0.5) * 0.5,
            (_random.nextDouble() - 0.5) * 0.5,
          ),
          radius: _random.nextDouble() * 2 + 1,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          _initParticles(
            Size(constraints.maxWidth, constraints.maxHeight),
          );
          return Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: NetworkPainter(
                        particles: _particles,
                        animationValue: _controller.value,
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(child: widget.child),
            ],
          );
        },
      ),
    );
  }
}

class NetworkPainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;

  final Color glowColor = AppPalette.secondaryCyan.withAlpha(38);
  final Paint _paintDot = Paint()..style = PaintingStyle.fill;
  final Paint _paintLine = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  NetworkPainter({
    required this.particles,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _paintDot.color = glowColor;

    for (var particle in particles) {
      particle.position += particle.velocity;

      if (particle.position.dx <= 0 ||
          particle.position.dx >= size.width) {
        particle.velocity = Offset(
          -particle.velocity.dx,
          particle.velocity.dy,
        );
      }
      if (particle.position.dy <= 0 ||
          particle.position.dy >= size.height) {
        particle.velocity = Offset(
          particle.velocity.dx,
          -particle.velocity.dy,
        );
      }

      canvas.drawCircle(
        particle.position,
        particle.radius,
        _paintDot,
      );
    }

    _paintLine.color = glowColor;
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final p1 = particles[i];
        final p2 = particles[j];
        final distance = (p1.position - p2.position).distance;

        if (distance < 100) {
          final opacity = (1 - distance / 100) * 0.2;
          _paintLine.color = AppPalette.secondaryCyan.withOpacity(
            opacity,
          );
          canvas.drawLine(p1.position, p2.position, _paintLine);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
