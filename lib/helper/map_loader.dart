import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

class MapLoader{
  static Future<List<Rect>> readWorldCollisionMap() async{
    List<Rect> collidableRact = [];

    var decodeData = jsonDecode(await rootBundle.loadString('assets/json/map.json'));

    for(var data in decodeData['objects']){
      collidableRact.add(Rect.fromLTRB(
          data['x'] as double,
          data['y'] as double,
          data['width'] as double,
          data['height'] as double)
      );
    }
    return collidableRact;
}
}