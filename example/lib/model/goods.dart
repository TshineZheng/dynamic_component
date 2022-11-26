class Goods {
    String? createdAt;
    String? goodsName;
    List<String>? goodsImage;
    String? goodsDetail;
    bool? isliked;
    int? type;
    ShopInfo? shopInfo;
    String? goodsId;

    Goods({this.createdAt, this.goodsName, this.goodsImage, this.goodsDetail, this.isliked, this.type, this.shopInfo, this.goodsId});

    Goods.fromJson(Map<String, dynamic> json) {
        createdAt = json["createdAt"];
        goodsName = json["goods_name"];
        goodsImage = json["goods_image"] == null ? null : List<String>.from(json["goods_image"]);
        goodsDetail = json["goods_detail"];
        isliked = json["isliked"];
        type = json["type"];
        shopInfo = json["shop_info"] == null ? null : ShopInfo.fromJson(json["shop_info"]);
        goodsId = json["goods_id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["createdAt"] = createdAt;
        _data["goods_name"] = goodsName;
        if(goodsImage != null) {
            _data["goods_image"] = goodsImage;
        }
        _data["goods_detail"] = goodsDetail;
        _data["isliked"] = isliked;
        _data["type"] = type;
        if(shopInfo != null) {
            _data["shop_info"] = shopInfo?.toJson();
        }
        _data["goods_id"] = goodsId;
        return _data;
    }

    Goods copyWith({
        String? createdAt,
        String? goodsName,
        List<String>? goodsImage,
        String? goodsDetail,
        bool? isliked,
        int? type,
        ShopInfo? shopInfo,
        String? goodsId,
    }) => Goods(
        createdAt: createdAt ?? this.createdAt,
        goodsName: goodsName ?? this.goodsName,
        goodsImage: goodsImage ?? this.goodsImage,
        goodsDetail: goodsDetail ?? this.goodsDetail,
        isliked: isliked ?? this.isliked,
        type: type ?? this.type,
        shopInfo: shopInfo ?? this.shopInfo,
        goodsId: goodsId ?? this.goodsId,
    );
}

class ShopInfo {
    String? shopName;
    String? shopLogo;

    ShopInfo({this.shopName, this.shopLogo});

    ShopInfo.fromJson(Map<String, dynamic> json) {
        shopName = json["shop_name"];
        shopLogo = json["shop_logo"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["shop_name"] = shopName;
        _data["shop_logo"] = shopLogo;
        return _data;
    }

    ShopInfo copyWith({
        String? shopName,
        String? shopLogo,
    }) => ShopInfo(
        shopName: shopName ?? this.shopName,
        shopLogo: shopLogo ?? this.shopLogo,
    );
}