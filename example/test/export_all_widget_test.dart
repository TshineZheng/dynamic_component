import 'dart:convert';
import 'dart:io';

import 'package:dynamic_component/dynamic_component.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:example/widget/flexible_parser.dart';
import 'package:example/widget/image_widget.dart';
import 'package:example/widget/my_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<DynamicComponent> components = [
    MyListItem(),
  ];

  setUp(() {
    DynamicWidgetBuilder.addParser(ImageWidgetParser());
    DynamicWidgetBuilder.addParser(FlexibleParser());
  });

  testWidgets('ExportAll', (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          List<Map<String, dynamic>> jsons = components.map((e) => e.exportJson(context)).toList();
          var fileJson = {
            'version': '1.0.0',
            'components': jsons,
          };

          final file = File('assets/components.json');

          if (file.existsSync()) file.deleteSync();

          // file.writeAsStringSync(jsonEncode(fileJson));

          file.writeAsStringSync(const JsonEncoder.withIndent("     ").convert(fileJson));

          return const Placeholder();
        },
      ),
    );
  });
}
