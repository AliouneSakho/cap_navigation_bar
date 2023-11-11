import 'package:flutter/material.dart';

class SelectedItemCustomPainter extends CustomPainter {
  final Color color;

  const SelectedItemCustomPainter({
    super.repaint,
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // Pentagon

    final Paint paintFill0 = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3726500, size.height * 0.3559200);
    path_0.quadraticBezierTo(size.width * 0.3768875, size.height * 0.1186600,
        size.width * 0.4970000, size.height * 0.0985800);
    path_0.quadraticBezierTo(size.width * 0.6281000, size.height * 0.1242200,
        size.width * 0.6269000, size.height * 0.3596400);
    path_0.quadraticBezierTo(size.width * 0.6260375, size.height * 0.5545400,
        size.width * 0.7506625, size.height * 0.6123400);
    path_0.lineTo(size.width * 0.2479375, size.height * 0.6087600);
    path_0.quadraticBezierTo(size.width * 0.3732125, size.height * 0.5468600,
        size.width * 0.3726500, size.height * 0.3559200);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Pentagon

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(0, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
