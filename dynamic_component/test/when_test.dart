import 'package:dynamic_component/src/when.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dynamic_component/foundation.dart';

void main() {
  setUp(() {
    DynamicWidgetBuilder.addParser(WhenParser());
  });
  group('when', () {
    final widget = When<int>(
      1.toDSLValue('type'),
      const {
        1: Text('1', overflow: TextOverflow.ellipsis),
        2: Text('2', overflow: TextOverflow.ellipsis),
      },
      defaultWidget: const Text('defaultWidget', overflow: TextOverflow.ellipsis),
    );

    const widgetMap4DM = {
      'type': 'When',
      'value': '@int:type',
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

    const widgetMapSelf = {
      'type': 'When',
      'value': 10,
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
      expect(map, equals(widgetMap4DM));
    });

    testWidgets('Parser', (WidgetTester tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (BuildContext context) {
            final widget = DynamicWidgetBuilder.buildFromMap(widgetMapSelf, context, null);
            expect(widget.runtimeType, equals(When));

            final realWidget = widget as When;
            expect(realWidget.value.value, equals(10));

            return const Placeholder();
          },
        ),
      );
    });
  });
}
