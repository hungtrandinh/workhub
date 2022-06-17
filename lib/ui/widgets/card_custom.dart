import 'package:flutter/material.dart';

class CardPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =Colors.orange
      ..style =PaintingStyle.fill
      ..strokeWidth= 8.0;
    final path = Path();
    path.moveTo(0, size.height /1.9);
    path.quadraticBezierTo(size.width /2,size.height/1.5 ,size.width,size.height/1.9);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }



  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}