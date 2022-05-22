// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_list_item.dart';

// **************************************************************************
// DynamicComponentGenerator
// **************************************************************************

const _myListItemDataForExport = {
  "goods_name": "#goodsName#",
  "goods_detail": "#goodsDetail#",
  "goods_image": "#goodsImage#",
  "isliked": "#isliked#",
  "createdAt": "#createdAt#",
};

mixin _$MyListItemComponent on DynamicComponent {
  late final String goodsName;
  late final String goodsDetail;
  late final String goodsImage;
  late final String isliked;
  late final String createdAt;

  void _setVariables() {
    goodsName = data?["goods_name"]?.toString() ?? " ";
    goodsDetail = data?["goods_detail"]?.toString() ?? " ";
    goodsImage = data?["goods_image"]?.toString() ?? " ";
    isliked = data?["isliked"]?.toString() ?? " ";
    createdAt = data?["createdAt"]?.toString() ?? " ";
  }

  @override
  Widget localBuild(BuildContext context) {
    _setVariables();
    return super.localBuild(context);
  }

  @override
  String get widgetType => 'MyListItem';

  @override
  Map<String, dynamic>? get dataRelation => {
        "#goodsName#": "goods_name",
        "#goodsDetail#": "goods_detail",
        "#goodsImage#": "goods_image",
        "#isliked#": "isliked",
        "#createdAt#": "createdAt",
      };
}
