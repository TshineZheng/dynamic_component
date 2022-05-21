import 'dart:convert';

import 'package:dynamic_component/dynamic_component.dart';
import 'package:flutter/material.dart';

class CodeEditorPage extends StatefulWidget {
  final DynamicComponent widget;
  const CodeEditorPage(
    this.widget, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CodeEditorPageState();
  }

  static push(BuildContext context, DynamicComponent widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CodeEditorPage(widget)));
  }
}

class _CodeEditorPageState extends State<CodeEditorPage> {
  TextEditingController controller = TextEditingController();

  _CodeEditorPageState();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      controller.text = getPrettyJSONString(jsonEncode(widget.widget.exportJson(context)));
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
