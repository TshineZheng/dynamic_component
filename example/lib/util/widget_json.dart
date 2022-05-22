import 'dart:convert';

import 'package:dynamic_component/dynamic_component.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Map<String, DSLInfo> widgetsCache = {};

DSLInfo? getWidgetDSLInfo(String name) {
  return widgetsCache[name];
}

Future<void> initDSLCache() async {
  WidgetsFlutterBinding.ensureInitialized();
  final str = await rootBundle.loadString('assets/components.json');
  final json = jsonDecode(str);
  final componentsJson = List.from(json['components']).map((e) => DSLInfo.fromMap(e));

  widgetsCache = {for (var v in componentsJson) v.type: v};
}
