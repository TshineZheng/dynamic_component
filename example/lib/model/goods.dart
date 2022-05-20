import 'package:flutter/foundation.dart';

@immutable
class Goods {
  const Goods({
    required this.goodsId,
    required this.goodsName,
    required this.goodsDetail,
    required this.goodsImage,
    required this.isliked,
  });

  final String goodsId;
  final String goodsName;
  final String goodsDetail;
  final String goodsImage;
  final bool isliked;

  factory Goods.fromJson(Map<String, dynamic> json) => Goods(
      goodsId: json['goods_id'].toString(),
      goodsName: json['goods_name'].toString(),
      goodsDetail: json['goods_detail'].toString(),
      goodsImage: json['goods_image'].toString(),
      isliked: json['isliked'] as bool);

  Map<String, dynamic> toJson() => {
        'goods_id': goodsId,
        'goods_name': goodsName,
        'goods_detail': goodsDetail,
        'goods_image': goodsImage,
        'isliked': isliked
      };

  Goods clone() =>
      Goods(goodsId: goodsId, goodsName: goodsName, goodsDetail: goodsDetail, goodsImage: goodsImage, isliked: isliked);

  Goods copyWith({String? goodsId, String? goodsName, String? goodsDetail, String? goodsImage, bool? isliked}) => Goods(
        goodsId: goodsId ?? this.goodsId,
        goodsName: goodsName ?? this.goodsName,
        goodsDetail: goodsDetail ?? this.goodsDetail,
        goodsImage: goodsImage ?? this.goodsImage,
        isliked: isliked ?? this.isliked,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Goods &&
          goodsId == other.goodsId &&
          goodsName == other.goodsName &&
          goodsDetail == other.goodsDetail &&
          goodsImage == other.goodsImage &&
          isliked == other.isliked;

  @override
  int get hashCode =>
      goodsId.hashCode ^ goodsName.hashCode ^ goodsDetail.hashCode ^ goodsImage.hashCode ^ isliked.hashCode;
}
