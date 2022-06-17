import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workhub/data/repository/export_reponsitory.dart';

import '../tinder/card_tinder_state.dart';





enum CardStatus { like, dislike, superLike }

class CardProvider extends ChangeNotifier {
  CardState _cardState = CardState.initial();

  CardState get cardState => _cardState;
  final PostRepository postRepository;

  CardProvider({required this.postRepository}) {
    resetUsers();
  }

  List<String> _urlImages = [];
  bool _isDragging = false;

  bool get isDragging => _isDragging;
  int count = 0;
  double _angle = 0;
  Offset _position = Offset.zero;

  Offset get position => _position;
  Size _screenSize = Size.zero;

  double get angle => _angle;

  List<String> get urlImages => _urlImages;

  Future<void> getPost() async {
    _cardState = _cardState.copyWith(cardState1: CardStatus1.loading);
    try {
      final dataPost = await postRepository.getPost();
      _cardState =
          _cardState.copyWith(cardState1: CardStatus1.success, post: dataPost);
      notifyListeners();
    } catch (_) {
      if (kDebugMode) {
        print("$_");
      }
    }
  }

  void setScreenSize(Size screenSize) {
    _screenSize = screenSize;
    notifyListeners();
  }

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    final x = position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    final status = getStatus();
    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superLike:
        supperLike();
        break;
      default:
        resetPosition();
    }

    notifyListeners();
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  void resetUsers() {
    {
      getPost();
      notifyListeners();
    }
  }

  void increment() {
    count++;
    notifyListeners();
  }

  CardStatus? getStatus() {
    final x = position.dx;
    final y = position.dy;
    const delta = 100;
    final forceSuperLike = x.abs() < 20;

    if (x >= delta) {
      return CardStatus.like;
    } else if (x <= -delta) {
      return CardStatus.dislike;
    } else if (y <= -delta / 2 && forceSuperLike) {
      return CardStatus.superLike;
    }
    return null;
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();
    notifyListeners();
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();
    notifyListeners();
  }

  void supperLike() {
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    _nextCard();
  }

  Future _nextCard() async {
    if (_cardState.post!.isEmpty) return;
    await Future.delayed(const Duration(milliseconds: 200));
    _cardState.post!.removeLast();
    resetPosition();
  }
}
