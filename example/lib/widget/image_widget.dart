import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String url;
  final double? compressionRatio;
  final double? width;
  final double? height;
  final bool enableMemoryCache;
  final bool clearMemoryCacheWhenDispose;
  final bool clearMemoryCacheIfFailed;
  final BoxFit? fit;
  final bool cache;

  const ImageWidget({
    Key? key,
    required this.url,
    this.compressionRatio,
    this.enableMemoryCache = true,
    this.clearMemoryCacheWhenDispose = false,
    this.clearMemoryCacheIfFailed = true,
    this.width,
    this.height,
    this.fit,
    this.cache = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      compressionRatio: compressionRatio,
      enableMemoryCache: enableMemoryCache,
      clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
      clearMemoryCacheIfFailed: clearMemoryCacheIfFailed,
      width: width,
      height: height,
      fit: fit,
      cache: cache,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Image.asset("assets/placeholder.png", fit: fit);
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.failed:
            return Image.asset("assets/placeholder.png", fit: fit);
        }
      },
    );
  }
}

class ImageWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    final realWidget = widget as ImageWidget;
    return {
      "type": widgetName,
      'url': realWidget.url,
      'compressionRatio': realWidget.compressionRatio,
      'width': realWidget.width,
      'height': realWidget.height,
      'enableMemoryCache': realWidget.enableMemoryCache,
      'clearMemoryCacheWhenDispose': realWidget.clearMemoryCacheWhenDispose,
      'clearMemoryCacheIfFailed': realWidget.clearMemoryCacheIfFailed,
      'fit': realWidget.fit?.toString(),
      'cache': realWidget.cache,
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickListener? listener) {
    return ImageWidget(
      url: map['url'],
      compressionRatio: map['compressionRatio'],
      width: map['width']?.toDouble(),
      height: map['height']?.toDouble(),
      enableMemoryCache: map['enableMemoryCache'],
      clearMemoryCacheWhenDispose: map['clearMemoryCacheWhenDispose'],
      clearMemoryCacheIfFailed: map['clearMemoryCacheIfFailed'],
      fit: map['fit'] == null ? null : BoxFit.values.firstWhere((e) => e.toString() == map['fit']),
      cache: map['cache'],
    );
  }

  @override
  String get widgetName => 'ImageWidget';

  @override
  Type get widgetType => ImageWidget;
}
