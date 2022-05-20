import 'dart:convert';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'if_or_not.dart';

final _defaultClickListener = NonResponseWidgetClickListener();

typedef OnTap = void Function(String event);

/// 支持参数传递的动态化组件。
/// 主要原理是在导出的json中，标记特殊字段，在解析时，将字段替换为实际参数，再交由 [DynamicWidgetBuilder] 解析为静态 Widget。
abstract class DynamicComponent extends StatelessWidget {
  /// 如果要在开发模式，强行使用 dsl，则设置为 true
  static var kTestDSL = false;

  /// 初始化，主要就是把本库必要的 [WidgetParser] 加入 [DynamicWidgetBuilder]
  static init() {
    DynamicWidgetBuilder.addParser(TapDetctorParse());
    DynamicWidgetBuilder.addParser(IFOrNotParse());
  }

  /// 业务数据
  final Map<String, dynamic>? data;

  /// 本组件中所有 [TapDetctor] 被点击时，会将 [TapDetctor.event] 回调到 [onTap] 中
  final OnTap? onTap;

  /// DSL数据，最好优化成从缓存获取, 仅 release 模式，或 [kTestDSL]== true 时会使用
  DSLInfo? get dslInfo;

  /// 如果不加这个，在DSL模式下，在列表中滚动会抖屏，建议传入一个简单组件，否则会影像性能
  final Widget? initialWidget;

  const DynamicComponent({
    this.data,
    this.onTap,
    Key? key,
    this.initialWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dslInfo == null || (kDebugMode && !kTestDSL)) {
      return buildWidget(context);
    }

    return FutureBuilder<Widget>(
      future: _buildJsonWidget(context),
      initialData: initialWidget,
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            print('=========================');
            print('DynamicComponent $runtimeType build failed, error: ${snapshot.error}');
            // print(dslInfo?.getDataChildDSL(data ?? {}) ?? '');
            print(snapshot.stackTrace);
          }
          return buildWidget(context);
        }
        return snapshot.hasData && snapshot.data != null ? snapshot.data! : const SizedBox.shrink();
      },
    );
  }

  /// 生产都走 json 解析
  Future<Widget> _buildJsonWidget(BuildContext context) async {
    ClickListener listener = _defaultClickListener;
    if (onTap != null) listener = _TapClickListener(onTap!);
    final childDSL = dslInfo?.getDataChildDSL(data ?? {}) ?? '';

    /// 将带数据的 json 解析为静态组件
    final ret = DynamicWidgetBuilder.build(childDSL, context, listener);

    if (kDebugMode) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
        ),
        child: ret!,
      );
    }

    return ret!;
  }

  /// 只有开发模式会走到这里
  Widget buildWidget(BuildContext context);
}

/// 导出动态参数动态组件需要混入这个，并定义导出的相关信息
mixin DynamicComponentExportMixin on DynamicComponent implements WidgetParser {
  /// 导出时需要使用
  late final _ExportInfo _exportInfo;

  Map<String, dynamic>? get dataRelation;

  @override
  Widget build(BuildContext context) {
    return _ChildHolder(buildWidget(context), key: _exportInfo.exportKey);
  }

  Widget genExport() {
    _exportInfo = _ExportInfo(exportKey: GlobalKey(), dataRelation: dataRelation ?? {});
    return this;
  }

  /// 导出时会将动态组件的相关信息写入 json
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as DynamicComponentExportMixin;

    var componentChild = realWidget._exportInfo.exportKey.currentWidget as _ChildHolder;

    Map<String, dynamic> json = {
      "type": widgetName,
      "dataRelation": realWidget._exportInfo.dataRelation,
      "child": DynamicWidgetBuilder.export(componentChild.child, buildContext)
    };

    return json;
  }

  /// 实际生产环境并不会真正解析成对应的 [DynamicComponent]，而是在对应 [DynamicComponent._buildJsonWidget] 方法中解析为静态组件
  ///
  /// 为什么不会解析成对应的 [DynamicComponent]? 因为交给 [DynamicWidgetBuilder.build] 的 json 中并不包含 [DynamicComponent] 信息。
  ///
  /// 所以下面返回什么都无所谓，压根不会走到这里
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickListener? listener) {
    return Container();
  }

  @override
  bool matchWidgetForExport(Widget? widget) => widget.runtimeType == widgetType;

  @override
  Type get widgetType => DynamicComponent;
}

/// 为了方便导出时，定位组件使用
class _ChildHolder extends StatelessWidget {
  final Widget child;
  const _ChildHolder(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

/// [DynamicComponent] 不需要 [ClickListener]，而是通过 [onTap] 自动创建的 兼容的 [_TapClickListener]。
///
/// !注意：dynamic_widget 自带的 [Container] 是支持在 json 中加入点击事件的。会自动传递到 [onTap] 中。
class _TapClickListener implements ClickListener {
  final OnTap onTap;

  _TapClickListener(this.onTap);

  @override
  void onClicked(String? event) {
    if (event != null) onTap(event);
  }
}

class TapDetctor extends StatelessWidget {
  /// 点击时回调 [onTap] 函数的值
  final String event;

  /// 谁要被点击
  final Widget child;

  /// 点击回调函数
  final OnTap? onTap;

  const TapDetctor({
    Key? key,
    required this.event,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onTap == null) return child;
    return GestureDetector(
      child: child,
      onTap: () => onTap!(event),
    );
  }
}

class TapDetctorParse extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as TapDetctor;
    return {
      "type": widgetName,
      "event": realWidget.event,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickListener? listener) {
    return TapDetctor(
      event: map['event'],
      onTap: (event) {
        listener?.onClicked(event);
      },
      child: DynamicWidgetBuilder.buildFromMap(map['child'], buildContext, listener)!,
    );
  }

  @override
  String get widgetName => 'TapDetctor';

  @override
  Type get widgetType => TapDetctor;
}

extension TapDectorExt on Widget {
  TapDetctor tap(String event, OnTap? onTap) {
    return TapDetctor(event: event, onTap: onTap, child: this);
  }
}

class DSLInfo {
  final String type;
  final Map<String, dynamic>? dataRelation;
  final String childDSL;

  DSLInfo({
    required this.type,
    required this.dataRelation,
    required this.childDSL,
  });

  factory DSLInfo.fromDSL(String dsl) {
    var widgetJson = jsonDecode(dsl);
    var type = widgetJson['type'];
    var childString = jsonEncode(widgetJson['child']);
    Map<String, dynamic>? jsonDataRelation;
    if (widgetJson.containsKey('dataRelation')) {
      jsonDataRelation = widgetJson['dataRelation'];
    }
    return DSLInfo(type: type, dataRelation: jsonDataRelation, childDSL: childString);
  }

  /// 通过关系表替换 childDSL 中的标记为真实数据，这样解析出来组件就带真实数据了
  String getDataChildDSL(Map<String, dynamic> data) {
    var childString = childDSL;
    // ignore: avoid_function_literals_in_foreach_calls
    dataRelation?.entries.forEach((element) {
      if (data.containsKey(element.value)) {
        childString = childString.replaceAll(element.key, data[element.value]!.toString().replaceAll('\n', '\\n'));
      }
    });
    return childString;
  }
}

class _ExportInfo {
  final GlobalKey exportKey;

  final Map<String, dynamic> dataRelation;

  _ExportInfo({required this.exportKey, required this.dataRelation});
}
