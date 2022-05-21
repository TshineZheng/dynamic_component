import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:example/widget/image_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    DynamicWidgetBuilder.addParser(ImageWidgetParse());
  });

  group('ImageWidget', () {
    const imageWidget = ImageWidget(
      url: 'http://baidu.com/1.jpg',
      compressionRatio: 1.0,
      width: 100,
      height: 100,
      enableMemoryCache: true,
      clearMemoryCacheWhenDispose: true,
      clearMemoryCacheIfFailed: true,
      fit: BoxFit.cover,
      cache: true,
    );

    const imageWidgetMap = {
      'type': 'ImageWidget',
      'url': 'http://baidu.com/1.jpg',
      'compressionRatio': 1.0,
      'width': 100.0,
      'height': 100.0,
      'enableMemoryCache': true,
      'clearMemoryCacheWhenDispose': true,
      'clearMemoryCacheIfFailed': true,
      'fit': 'BoxFit.cover',
      'cache': true,
    };

    test('Export', () {
      final map = DynamicWidgetBuilder.export(imageWidget, null);
      expect(map, equals(imageWidgetMap));
    });

    testWidgets('Parser', (WidgetTester tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (BuildContext context) {
            final widget = DynamicWidgetBuilder.buildFromMap(imageWidgetMap, context, null);
            expect(widget.runtimeType, equals(ImageWidget));

            final map = DynamicWidgetBuilder.export(widget, null);
            expect(map, equals(imageWidgetMap));

            return const Placeholder();
          },
        ),
      );
    });
  });
}
