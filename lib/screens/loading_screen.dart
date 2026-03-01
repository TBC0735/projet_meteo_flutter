import 'package:flutter/material.dart';
import 'package:untitled/screens/page_mete.dart';
import 'dart:math';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _percent = 0;
  int _messageIndex = 0; // Index du message actuel

  // Les 3 messages qui tournent en boucle
  final List<String> _messages = [
    "Nous téléchargeons les données… 📡",
    "C'est presque fini... ⏳",
    "Plus que quelques secondes avant d'avoir le résultat… 🗺️",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _startLoading();   // Lance le pourcentage
    _startMessages();  // Lance les messages indépendamment
  }

  // Messages qui tournent en boucle toutes les 2 secondes
  Future<void> _startMessages() async {
    while (mounted && _percent < 100) {
      await Future.delayed(const Duration(milliseconds: 2000));
      if (!mounted) return;
      setState(() {
        _messageIndex = (_messageIndex + 1) % _messages.length; // Tourne en boucle
      });
    }
  }

  // Pourcentage qui monte de 10 en 10
  Future<void> _startLoading() async {
    for (int i = 10; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (!mounted) return;
      setState(() {
        _percent = i;
      });
    }

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PageMete()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 220,
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: _percent / 100),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return CustomPaint(
                        size: const Size(220, 220),
                        painter: _CirclePainter(value),
                      );
                    },
                  ),
                  TweenAnimationBuilder<int>(
                    tween: IntTween(begin: 0, end: _percent),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Text(
                        "$value%",
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1F36),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Message animé qui change en fondu
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: Text(
                _messages[_messageIndex],
                key: ValueKey(_messageIndex), // Change l'animation à chaque nouveau message
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double progress;
  _CirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 14.0;

    final bgPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final fgPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_CirclePainter old) => old.progress != progress;
}