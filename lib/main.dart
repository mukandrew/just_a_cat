import 'package:flutter/material.dart';

import 'cat_widget.dart';

void main() {
  runApp(JustCatApp());
}

class JustCatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just A Cat',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Just A Cat'),
        ),
        body: CatCatalog(),
      ),
    );
  }
}

enum SwipeDirection { leftToRight, rightToLeft }
