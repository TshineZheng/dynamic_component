import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';

class When extends StatelessWidget {
  final String value;
  final Map<String, Widget> cases;
  final Widget? defaultWidget;
  const When(this.value, this.cases, {Key? key, this.defaultWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final m = cases[value];
    if (m != null) return m;
    return defaultWidget ?? const SizedBox.shrink();
  }
}

class WhenParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as When;
    return {
      'type': widgetName,
      'value': realWidget.value,
      'cases': realWidget.cases.map((key, value) => MapEntry(key, DynamicWidgetBuilder.export(value, buildContext))),
      'defaultWidget': DynamicWidgetBuilder.export(realWidget.defaultWidget, buildContext),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickListener? listener) {
    return When(
      map['value'],
      (map['cases'] as Map)
          .map((key, value) => MapEntry(key, DynamicWidgetBuilder.buildFromMap(value, buildContext, listener)!)),
      defaultWidget: DynamicWidgetBuilder.buildFromMap(map['defaultWidget'], buildContext, listener),
    );
  }

  @override
  String get widgetName => 'When';

  @override
  Type get widgetType => When;
}
