import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DrawingProvider extends ChangeNotifier {
  List<DrawingArea> _drawing = [];

  List<DrawingArea> get drawing => _drawing;
  double _stroke = 2;

  double get stroke => _stroke;
  Color _colors = Colors.black;

  Color get colors => _colors;
  bool _state = false;

  bool get state => _state;

  void setStateDrawing() {
    _state = !_state;
    notifyListeners();
  }

  void updateColor(Color color) {
    _colors = color;
    notifyListeners();
  }

  void updateStroke(double stroke) {
    _stroke = stroke;
    notifyListeners();
  }

  void delete() {
    _drawing = [];
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    if (_state == false) {
      _drawing.add(DrawingArea(
          point: details.localPosition,
          areaPaint: Paint()
            ..strokeCap = StrokeCap.round
            ..isAntiAlias = true
            ..color = _colors
            ..strokeWidth = _stroke));
      notifyListeners();
    } else {
      _drawing.removeWhere((item) => item.point == details.localPosition);
      notifyListeners();
    }
  }

  void downPosition(DragDownDetails details) {
    if (_state == false) {
      _drawing.add(DrawingArea(
          point: details.localPosition,
          areaPaint: Paint()
            ..strokeCap = StrokeCap.round
            ..isAntiAlias = true
            ..color = _colors
            ..strokeWidth = _stroke));
      notifyListeners();
    } else {
      _drawing.removeWhere((item) => item.point == details.localPosition);
      notifyListeners();
    }
    if (kDebugMode) {
      print(_drawing.length);
    }
  }

  void endPosition() {
    if(_state==false){
      _drawing.add(DrawingArea(point: Offset.infinite, areaPaint: Paint()));
    }else{
      _drawing.remove(DrawingArea(point: Offset.infinite, areaPaint: Paint()));
    }

    notifyListeners();
  }
}

class DrawingArea {
  Offset point;
  Paint areaPaint;

  DrawingArea({required this.point, required this.areaPaint});
}
