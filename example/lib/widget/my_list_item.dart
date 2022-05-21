import 'package:dynamic_component/dynamic_component.dart';
import 'package:example/widget/image_widget.dart';
import 'package:flutter/material.dart';

import '../util/widget_json.dart';

@Variables([
  'goods_name',
  'goods_detail',
  'goods_image',
  'isliked',
])

/// 这是一个支持参数传递的动态组件示例
class MyListItem extends DynamicComponent {
  /// 新组件一般只要复制整个构造函数，改下名字就可以，因为 ParmWidget 是通过 Map 传递参数，所以一般不会需要其他参数。
  const MyListItem({
    required Map<String, dynamic> data,
    Key? key,
    OnTap? onTap,
  }) : super(key: key, data: data, onTap: onTap);

  @override
  DSLInfo? get dslInfo => getWidgetDSLInfo(MyListItemExport._widgetName);

  /// 作用同 StatelessWidget.build
  @override
  Widget buildWidget(BuildContext context) {
    final title = data!['goods_name'] ?? '';
    final content = data!['goods_detail'] ?? '';
    final image = data!['goods_image'] ?? '';
    final like = data!['isliked']?.toString() ?? 'false';

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: ImageWidget(
                        url: image,
                        fit: BoxFit.fitHeight,
                        cache: false,
                      ).tap('image', onTap),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Text(
                          title,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 24, color: Colors.white),
                        ).tap('title', onTap),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: -3,
                      child: IfOrNot(
                        actual: like,
                        expect: 'false',
                        matched: const Text('♡', style: TextStyle(color: Colors.red, fontSize: 30)),
                        failed: const Text('♥', style: TextStyle(color: Colors.red, fontSize: 30)),
                      ).tap('like', onTap),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          content,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                        ).tap('content', onTap),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 定义导出时用的一些信息，需要将此类实例化并加入 [DynamicWidgetBuilder.addParser]
///
/// 导出时调用 [MyListItemExport.gen]
class MyListItemExport extends MyListItem with DynamicComponentExportMixin {
  /// json 中的特殊标记和业务数据 [ParmWidget.data] 的映射表
  /// 以下面举例，当 json 中出现 #title#，则替换为 data['goods_name']
  /// {
  ///   "#title#": "goods_name",
  ///   "#content#": "goods_detail",
  ///   "#image#": 'goods_image',
  /// }
  static const _dataRelation = {
    "#title#": "goods_name",
    "#content#": "goods_detail",
    "#image#": "goods_image",
    "#isliked#": "isliked"
  };

  static const _widgetName = 'MyListItem';

  /// * 组件名称
  @override
  String get widgetName => _widgetName;

  /// * 这里要使用当前类的名称，否则会匹配不上 Parse
  @override
  Type get widgetType => MyListItemExport;

  /// * 关系表
  @override
  Map<String, String>? get dataRelation => _dataRelation;

  /// * 除了名字其他都可以不改，这里主要是把关系表倒转下当做 data 传进去，方便导出时自动填充关键字
  MyListItemExport({Key? key})
      : super(
          key: key,
          data: _dataRelation.map((key, value) => MapEntry(value, key)),
        );
}
