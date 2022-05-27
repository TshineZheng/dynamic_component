import 'package:dynamic_component/src/foundation.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

/// 带逻辑判断的组件
class IfOrNot<T> extends StatelessWidget {
  /// 实际值
  final DSLValue<T> actual;

  /// 预期值
  final T expect;

  /// [actual] == [expect] 时展示
  final Widget matched;

  /// [actual] != [expect] 时展示
  final Widget failed;

  const IfOrNot({Key? key, required this.actual, required this.expect, required this.matched, required this.failed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (actual.value == expect) {
      return matched;
    }
    return failed;
  }

  static IfOrNot<bool> boolean(DSLValue<bool> value, Widget? tureWidget, Widget? falseWidget) {
    return IfOrNot<bool>(
      actual: value,
      expect: true,
      matched: tureWidget ?? const SizedBox.shrink(),
      failed: falseWidget ?? const SizedBox.shrink(),
    );
  }
}

class IfOrNotParse extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as IfOrNot;
    return {
      "type": widgetName,
      "actual": realWidget.actual.toDSLKeyword(),
      "expect": realWidget.expect,
      "matched": DynamicWidgetBuilder.export(realWidget.matched, buildContext),
      "failed": DynamicWidgetBuilder.export(realWidget.failed, buildContext),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickListener? listener) {
    return IfOrNot(
      actual: DSLValue.fromDSLKeyword(map['actual']),
      expect: map['expect'],
      matched: DynamicWidgetBuilder.buildFromMap(map['matched'], buildContext, listener)!,
      failed: DynamicWidgetBuilder.buildFromMap(map['failed'], buildContext, listener)!,
    );
  }

  @override
  String get widgetName => 'IfOrNot';

  @override
  Type get widgetType => IfOrNot;

  @override
  bool matchWidgetForExport(Widget? widget) {
    return widget is IfOrNot;
  }
}
