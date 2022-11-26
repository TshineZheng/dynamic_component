// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_list_item.dart';

// **************************************************************************
// DynamicComponentGenerator
// **************************************************************************

mixin _$MyListItemComponent on DynamicComponent {
  late final String goodsName;
  late final String goodsDetail;
  late final String goodsImage0;
  late final String isliked;
  late final String createdAt;
  late final String type;
  late final String shopInfoShopName;
  late final String shopInfoShopLogo;

  void _setVariables() {
    goodsName = JsonUtil.jsonGet(data, "goods_name")?.toString() ?? "";
    goodsDetail = JsonUtil.jsonGet(data, "goods_detail")?.toString() ?? "";
    goodsImage0 = JsonUtil.jsonGet(data, "goods_image.0")?.toString() ?? "";
    isliked = JsonUtil.jsonGet(data, "isliked")?.toString() ?? "";
    createdAt = JsonUtil.jsonGet(data, "createdAt")?.toString() ?? "";
    type = JsonUtil.jsonGet(data, "type")?.toString() ?? "";
    shopInfoShopName =
        JsonUtil.jsonGet(data, "shop_info.shop_name")?.toString() ?? "";
    shopInfoShopLogo =
        JsonUtil.jsonGet(data, "shop_info.shop_logo")?.toString() ?? "";
  }

  void _setVariables4Export() {
    goodsName = '#goodsName#';
    goodsDetail = '#goodsDetail#';
    goodsImage0 = '#goodsImage0#';
    isliked = '#isliked#';
    createdAt = '#createdAt#';
    type = '#type#';
    shopInfoShopName = '#shopInfoShopName#';
    shopInfoShopLogo = '#shopInfoShopLogo#';
  }

  @override
  Widget localBuild(BuildContext context) {
    if (null != data) {
      _setVariables();
    } else {
      _setVariables4Export();
    }

    return super.localBuild(context);
  }

  @override
  String get widgetType => 'MyListItem';

  @override
  Map<String, dynamic>? get dataRelation => {
        '#goodsName#': 'goods_name',
        '#goodsDetail#': 'goods_detail',
        '#goodsImage0#': 'goods_image.0',
        '#isliked#': 'isliked',
        '#createdAt#': 'createdAt',
        '#type#': 'type',
        '#shopInfoShopName#': 'shop_info.shop_name',
        '#shopInfoShopLogo#': 'shop_info.shop_logo',
      };
}
