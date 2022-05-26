import 'package:dynamic_component/dynamic_component.dart';
import 'package:dynamic_component/foundation.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    DynamicWidgetBuilder.addParser(IfOrNotParse());
  });
  group('IfOrNot String', () {
    final widget = IfOrNot<String>(
      actual: '#actual#'.toValue(),
      expect: 'expect',
      matched: const Text('matched', overflow: TextOverflow.ellipsis),
      failed: const Text('failed', overflow: TextOverflow.ellipsis),
    );

    const widgetMap = {
      'type': 'IfOrNot',
      'actual': '#actual#',
      'expect': 'expect',
      'matched': {
        "type": "Text",
        "data": "matched",
        "textAlign": "start",
        "overflow": 'ellipsis',
        "maxLines": null,
        "semanticsLabel": null,
        "softWrap": null,
        "textDirection": "ltr",
        "style": null,
        "textScaleFactor": null,
      },
      'failed': {
        "type": "Text",
        "data": "failed",
        "textAlign": "start",
        "overflow": 'ellipsis',
        "maxLines": null,
        "semanticsLabel": null,
        "softWrap": null,
        "textDirection": "ltr",
        "style": null,
        "textScaleFactor": null,
      },
    };

    test('Export', () {
      final map = DynamicWidgetBuilder.export(widget, null);
      expect(map, equals(widgetMap));
    });

    testWidgets('Parser', (WidgetTester tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (BuildContext context) {
            final widget = DynamicWidgetBuilder.buildFromMap(widgetMap, context, null);
            expect(widget.runtimeType, equals(IfOrNot));

            final map = DynamicWidgetBuilder.export(widget, null);
            expect(map, equals(widgetMap));

            return const Placeholder();
          },
        ),
      );
    });
  });

  group('IfOrNot bool', () {
    final widget = IfOrNot<bool>(
      actual: true.toValue("isLike"),
      expect: true,
      matched: const Text('matched', overflow: TextOverflow.ellipsis),
      failed: const Text('failed', overflow: TextOverflow.ellipsis),
    );

    const widgetMap = {
      'type': 'IfOrNot',
      'actual': '@bool:isLike',
      'expect': true,
      'matched': {
        "type": "Text",
        "data": "matched",
        "textAlign": "start",
        "overflow": 'ellipsis',
        "maxLines": null,
        "semanticsLabel": null,
        "softWrap": null,
        "textDirection": "ltr",
        "style": null,
        "textScaleFactor": null,
      },
      'failed': {
        "type": "Text",
        "data": "failed",
        "textAlign": "start",
        "overflow": 'ellipsis',
        "maxLines": null,
        "semanticsLabel": null,
        "softWrap": null,
        "textDirection": "ltr",
        "style": null,
        "textScaleFactor": null,
      },
    };

    test('Export', () {
      final map = DynamicWidgetBuilder.export(widget, null);
      expect(map, equals(widgetMap));
    });

    testWidgets('Parser', (WidgetTester tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (BuildContext context) {
            final widget = DynamicWidgetBuilder.buildFromMap(widgetMap, context, null);
            expect(widget.runtimeType, equals(IfOrNot));

            final map = DynamicWidgetBuilder.export(widget, null);
            expect(map, equals(widgetMap));

            return const Placeholder();
          },
        ),
      );
    });
  });
}
