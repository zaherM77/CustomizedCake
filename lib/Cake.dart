import 'package:flutter/material.dart';
class Cake {
  Color _color;
  String _frosting;
  String _cakeTopper;
  int _nbLayers;
  String _flavore;

  // Default-valued constructor
  Cake({
    Color color = Colors.brown,
    String frosting = 'Buttercream',
    String cakeTopper = '',
    int nbLayers = 1,
    String flavore='Vanilla'
  })  : _color = color,
        _frosting = frosting,
        _cakeTopper = cakeTopper,
        _nbLayers = nbLayers,
        _flavore = flavore;

  String get flavore => _flavore;

  set flavore(String value) {
    _flavore = value;
  }

  int get nbLayers => _nbLayers;

  set nbLayers(int value) {
    _nbLayers = value;
  }

  String get frosting => _frosting;

  set frosting(String value) {
    _frosting = value;
  }

  String get cakeTopper => _cakeTopper;

  Color get color => _color;

  set color(Color value) {
    _color = value;
  }

  set cakeTopper(String value) {
    _cakeTopper = value;
  }
}
List <Cake> cakes =[];
