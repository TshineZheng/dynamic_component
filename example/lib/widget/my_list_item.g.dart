// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_list_item.dart';

// **************************************************************************
// DynamicComponentGenerator
// **************************************************************************

const _myListItemDataRelation = {
  "#goodsName#": "goods_name",
  "#goodsDetail#": "goods_detail",
  "#goodsImage#": "goods_image",
  "#isliked#": "isliked",
};

const _myListItemDataForExport = {
  "goods_name": "#goodsName#",
  "goods_detail": "#goodsDetail#",
  "goods_image": "#goodsImage#",
  "isliked": "#isliked#",
};

mixin _$MyListItemComponent on DynamicComponent {
  late final String goodsName;
  late final String goodsDetail;
  late final String goodsImage;
  late final String isliked;

  void _setVariables() {
    goodsName = data?["goods_name"]?.toString() ?? " ";
    goodsDetail = data?["goods_detail"]?.toString() ?? " ";
    goodsImage = data?["goods_image"]?.toString() ?? " ";
    isliked = data?["isliked"]?.toString() ?? " ";
  }

  @override
  Widget localBuild(BuildContext context) {
    _setVariables();
    return super.localBuild(context);
  }
}

mixin _$MyListItemExport on DynamicComponentExportMixin {
  @override
  String get widgetName => 'MyListItem';

  @override
  Type get widgetType => MyListItemExport;

  @override
  Map<String, String>? get dataRelation => _myListItemDataRelation;
}
