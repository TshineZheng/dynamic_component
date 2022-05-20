import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class FlexibleParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Flexible;
    return {
      "type": widgetName,
      "flex": realWidget.flex,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickListener? listener) {
    return Expanded(
      flex: map['flex'],
      child: DynamicWidgetBuilder.buildFromMap(map['child'], buildContext, listener)!,
    );
  }

  @override
  String get widgetName => 'Flexible';

  @override
  Type get widgetType => Flexible;
}
