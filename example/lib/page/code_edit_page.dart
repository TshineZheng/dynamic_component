import 'dart:convert';

import 'package:dynamic_component/dynamic_component.dart';
import 'package:dynamic_widget/dynamic_widget/basic/dynamic_widget_json_exportor.dart';
import 'package:flutter/material.dart';

class CodeEditorPage extends StatefulWidget {
  final DynamicComponentExportMixin widget;
  const CodeEditorPage(
    this.widget, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CodeEditorPageState();
  }

  static push(BuildContext context, DynamicComponentExportMixin widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CodeEditorPage(widget)));
  }
}

class _CodeEditorPageState extends State<CodeEditorPage> {
  GlobalKey key = GlobalKey();
  TextEditingController controller = TextEditingController();

  _CodeEditorPageState();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      var exportor = key.currentWidget as DynamicWidgetJsonExportor;
      controller.text = getPrettyJSONString(exportor.exportJsonString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DSL Export"),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              DynamicWidgetJsonExportor(
                key: key,
                child: widget.widget.genExport(),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints.expand(width: double.infinity, height: double.infinity),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Enter json string'),
                    maxLines: 1000000,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String getPrettyJSONString(String jsonString) {
    var encoder = const JsonEncoder.withIndent("  ");
    return encoder.convert(json.decode(jsonString));
  }
}
