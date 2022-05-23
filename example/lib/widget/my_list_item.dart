import 'package:dynamic_component/dynamic_component.dart';
import 'package:dynamic_component/dynamic_component_anotation.dart';
import 'package:example/widget/image_widget.dart';
import 'package:flutter/material.dart';

import '../util/widget_json.dart';

part 'my_list_item.g.dart';

@Component(variables: [
  'goods_name',
  'goods_detail',
  'goods_image',
  'isliked',
  'createdAt',
])
class MyListItem extends DynamicComponent with _$MyListItemComponent {
  MyListItem({
    required Map<String, dynamic> data,
    Key? key,
    OnTap? onTap,
  }) : super(
            key: key,
            data: data,
            onTap: onTap,
            initialWidget: const AspectRatio(
              aspectRatio: 640 / 480,
              child: Center(child: Text('Loading……')),
            ));

  /// 作用同 StatelessWidget.build
  @override
  Widget buildWidget(BuildContext context) {
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
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 640 / 480,
                        child: ImageWidget(
                          url: goodsImage,
                          fit: BoxFit.fitWidth,
                          cache: true,
                        ).tap('image', onTap),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Text(
                          goodsName,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 24, color: Colors.white),
                        ).tap('title', onTap),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: -3,
                      child: IfOrNot(
                        actual: isliked,
                        expect: 'false',
                        matched: const Text('♡', style: TextStyle(color: Colors.red, fontSize: 30)),
                        failed: const Text('♥', style: TextStyle(color: Colors.red, fontSize: 30)),
                      ).tap('like', onTap),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              goodsDetail,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                            ).tap('content', onTap),
                          )
                        ],
                      ),
                      Text(createdAt),
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

  @override
  DSLInfo? get dslInfo => getWidgetDSLInfo(widgetType);

  static DynamicComponent export() => MyListItem(data: _myListItemDataForExport);
}
