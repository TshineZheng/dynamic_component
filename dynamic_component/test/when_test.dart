import 'package:dynamic_component/src/when.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    DynamicWidgetBuilder.addParser(WhenParser());
  });
  group('when', () {
    const widget = When(
      'value',
      {
        '1': Text('1', overflow: TextOverflow.ellipsis),
        '2': Text('2', overflow: TextOverflow.ellipsis),
      },
      defaultWidget: Text('defaultWidget', overflow: TextOverflow.ellipsis),
    );

    const widgetMap = {
      'type': 'When',
      'value': 'value',
      'cases': {
        '1': {
          "type": "Text",
          "data": "1",
          "textAlign": "start",
          "overflow": 'ellipsis',
          "maxLines": null,
          "semanticsLabel": null,
          "softWrap": null,
          "textDirection": "ltr",
          "style": null,
          "textScaleFactor": null
        },
        '2': {
          "type": "Text",
          "data": "2",
          "textAlign": "start",
          "overflow": 'ellipsis',
          "maxLines": null,
          "semanticsLabel": null,
          "softWrap": null,
          "textDirection": "ltr",
          "style": null,
          "textScaleFactor": null
        },
      },
      'defaultWidget': {
        "type": "Text",
        "data": "defaultWidget",
        "textAlign": "start",
        "overflow": 'ellipsis',
        "maxLines": null,
        "semanticsLabel": null,
        "softWrap": null,
        "textDirection": "ltr",
        "style": null,
        "textScaleFactor": null
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
            expect(widget.runtimeType, equals(When));

            final map = DynamicWidgetBuilder.export(widget, null);
            expect(map, equals(widgetMap));

            return const Placeholder();
          },
        ),
      );
    });
  });
}
