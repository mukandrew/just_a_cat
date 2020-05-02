import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:justacat/slide_transition.dart';

import 'main.dart';

class CatCatalog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CatCatalogState();
}

class _CatCatalogState extends State<CatCatalog> {
  final int _animationTimeInMs = 300;
  final int _firstCatPosition = 1;
  final int _lastCatPosition = 50;
  int _currentPosition = 1;
  bool _reverseAnimation = false;
  double _initialDragPosition = 0;
  double _dragDistance = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => _setCatPosition(SwipeDirection.rightToLeft),
            ),
            flex: 1,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: ClipRect(
              child: GestureDetector(
                onPanStart: (details) {
                  _initialDragPosition = details.globalPosition.dx;
                },
                onPanUpdate: (details) {
                  _dragDistance = details.globalPosition.dx - _initialDragPosition;
                },
                onPanEnd: (details) {
                  if (_dragDistance.isNegative) {
                    _setCatPosition(SwipeDirection.rightToLeft);
                  } else {
                    _setCatPosition(SwipeDirection.leftToRight);
                  }
                },
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: _animationTimeInMs),
                  transitionBuilder: (child, animation) {
                    if (child.key == Key(_getCatPositionText())) {
                      return Slide.enterOffsetX(
                          child, animation, _reverseAnimation);
                    } else {
                      return Slide.exitOffsetX(
                          child, animation, _reverseAnimation);
                    }
                  },
                  child: _getCatImage(_getCatPositionText()),
                ),
              ),
            ),
            flex: 2,
          ),
          Flexible(
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () => _setCatPosition(SwipeDirection.leftToRight),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget _getCatImage(String number) {
    return Image.asset(
      'images/$number-kitty.png',
      key: Key(number),
    );
  }

  String _getCatPositionText() {
    return _currentPosition < 10
        ? '0$_currentPosition'
        : _currentPosition.toString();
  }

  _setCatPosition(SwipeDirection direction) {
    switch (direction) {
      case SwipeDirection.leftToRight:
        _reverseAnimation = true;
        _currentPosition--;
        if (_currentPosition < _firstCatPosition)
          _currentPosition = _lastCatPosition;
        break;
      case SwipeDirection.rightToLeft:
        _reverseAnimation = false;
        _currentPosition++;
        if (_currentPosition > _lastCatPosition)
          _currentPosition = _firstCatPosition;
        break;
    }
    setState(() {});
  }
}
