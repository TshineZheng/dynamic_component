import 'package:dynamic_component/foundation.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';

class When<T> extends StatelessWidget {
  final DSLValue<T> value;
  final Map<T, Widget> cases;
  final Widget? defaultWidget;
  const When(this.value, this.cases, {Key? key, this.defaultWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final m = cases[value.value];
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
      'value': realWidget.value.toDSLKeyword(),
      'cases': realWidget.cases.map((key, value) => MapEntry(
            key.toString(),
            DynamicWidgetBuilder.export(value, buildContext),
          )),
      'defaultWidget': DynamicWidgetBuilder.export(realWidget.defaultWidget, buildContext),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickListener? listener) {
    final dslValue = DSLValue.fromValue(map['value']);
    return When(
      dslValue,
      (map['cases'] as Map).map((key, value) => MapEntry(
            _parseCaseKey(dslValue, key),
            DynamicWidgetBuilder.buildFromMap(value, buildContext, listener)!,
          )),
      defaultWidget: DynamicWidgetBuilder.buildFromMap(map['defaultWidget'], buildContext, listener),
    );
  }

  dynamic _parseCaseKey(DSLValue dslValue, String str) {
    if (dslValue.value is int) {
      return int.parse(str);
    } else if (dslValue.value is bool) {
      if (str == 'true') return true;
      return false;
    } else if (dslValue.value is double) {
      return double.parse(str);
    } else {
      return str;
    }
  }

  @override
  String get widgetName => 'When';

  @override
  Type get widgetType => When;

  @override
  bool matchWidgetForExport(Widget? widget) {
    return widget is When;
  }
}
