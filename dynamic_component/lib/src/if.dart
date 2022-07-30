import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

/// 带逻辑判断的组件
class If extends StatelessWidget {
  /// 实际值
  final String actual;

  /// 预期值
  final String expect;

  /// [actual] == [expect] 时展示
  final Widget matched;

  /// [actual] != [expect] 时展示
  final Widget failed;

  const If({
    Key? key,
    required this.actual,
    required this.expect,
    required this.matched,
    required this.failed,
  }) : super(key: key);

  factory If.bool(String boolValue, Widget t, Widget? f) {
    return If(
      actual: boolValue == 'true' ? 'true' : 'false',
      expect: 'true',
      matched: t,
      failed: f ?? const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (actual == expect) {
      return matched;
    }
    return failed;
  }
}

class IfParse extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as If;
    return {
      "type": widgetName,
      "actual": realWidget.actual,
      "expect": realWidget.expect,
      "matched": DynamicWidgetBuilder.export(realWidget.matched, buildContext),
      "failed": DynamicWidgetBuilder.export(realWidget.failed, buildContext),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickListener? listener) {
    return If(
      actual: map['actual'],
      expect: map['expect'],
      matched: DynamicWidgetBuilder.buildFromMap(map['matched'], buildContext, listener)!,
      failed: DynamicWidgetBuilder.buildFromMap(map['failed'], buildContext, listener)!,
    );
  }

  @override
  String get widgetName => 'If';

  @override
  Type get widgetType => If;
}
