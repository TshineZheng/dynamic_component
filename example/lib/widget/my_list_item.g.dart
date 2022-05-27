// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_list_item.dart';

// **************************************************************************
// DynamicComponentGenerator
// **************************************************************************

const _myListItemDataForExport = {
  "goods_name": "#goods_name#",
  "goods_detail": "#goods_detail#",
  "goods_image": "#goods_image#",
  "isliked": false,
  "createdAt": "#createdAt#",
  "type": 0,
  "delivery_status": 0,
  "delivery_process": 0.0,
};

mixin _$MyListItemComponent on DynamicComponent {
  late final String goodsName;
  late final String goodsDetail;
  late final String goodsImage;
  late final DSLValue<bool> isliked;
  late final String createdAt;
  late final DSLValue<int> type;
  late final DSLValue<int> deliveryStatus;
  late final DSLValue<double> deliveryProcess;

  void _setVariables() {
    goodsName = data?["goods_name"]?.toString() ?? "";
    goodsDetail = data?["goods_detail"]?.toString() ?? "";
    goodsImage = data?["goods_image"]?.toString() ?? "";
    isliked = DSLValue(value: data?["isliked"] ?? false, dataName: "isliked");
    createdAt = data?["createdAt"]?.toString() ?? "";
    type = DSLValue(value: data?["type"] ?? 0, dataName: "type");
    deliveryStatus = DSLValue(
        value: data?["delivery_status"] ?? 0, dataName: "delivery_status");
    deliveryProcess = DSLValue(
        value: data?["delivery_process"] ?? 0.0, dataName: "delivery_process");
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
        "#goods_name#": "goods_name",
        "#goods_detail#": "goods_detail",
        "#goods_image#": "goods_image",
        "@bool:isliked": "isliked",
        "#createdAt#": "createdAt",
        "@int:type": "type",
        "@int:delivery_status": "delivery_status",
        "@double:delivery_process": "delivery_process",
      };
}
