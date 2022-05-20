// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:dynamic_component/dynamic_component.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/basic/dynamic_widget_json_exportor.dart';
import 'package:example/util/widget_json.dart';
import 'package:example/widget/flexible_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'model/goods.dart';
import 'util/fake_data.dart';
import 'widget/my_list_item.dart';

void main() {
  DynamicComponent.init();

  DynamicWidgetBuilder.addParser(FlexibleParser());
  DynamicWidgetBuilder.addParser(MyListItemExport());

  initDSLCache();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Goods> goodsList;

  @override
  void initState() {
    super.initState();
    Iterable l = json.decode(goodsData);
    goodsList = List<Goods>.from(l.map((model) => Goods.fromJson(model)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          controller: AdjustableScrollController(80),
          child: MasonryGridView.count(
            // 展示几列
            crossAxisCount: 3,
            // 元素总个数
            itemCount: goodsList.length,
            // 纵向元素间距
            mainAxisSpacing: 10,
            // 横向元素间距
            crossAxisSpacing: 10,
            //本身不滚动，让外面的singlescrollview来滚动
            physics: const NeverScrollableScrollPhysics(),
            //收缩，让元素宽度自适应
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = goodsList[index];
              return MyListItem(
                data: data.toJson(),
                onTap: (event) => onItemClick(index, data, event),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CodeEditorPage()));
              });
            },
            tooltip: 'export dsl',
            child: const Text('Export'),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                DynamicComponent.kTestDSL = !DynamicComponent.kTestDSL;
              });
            },
            tooltip: 'switch build mode',
            child: Center(
              child: Text(
                '${DynamicComponent.kTestDSL ? 'DSL' : 'DEV'}\nMODE',
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  void onItemClick(int index, Goods goods, String event) {
    switch (event) {
      case 'title':
        print('点击了 ID = ${goods.goodsId} 的标题');
        break;
      case 'content':
        print('点击了 ID = ${goods.goodsId} 的内容');
        break;
      case 'image':
        print('点击了 ID = ${goods.goodsId} 的图片');
        break;
      case 'like':
        setState(() {
          goodsList[index] = goods.copyWith(isliked: !(goods.isliked));
        });
        print('点击了 ID = ${goods.goodsId} 的点赞');
        break;
      default:
    }
  }
}

class AdjustableScrollController extends ScrollController {
  AdjustableScrollController([int extraScrollSpeed = 40]) {
    super.addListener(() {
      ScrollDirection scrollDirection = super.position.userScrollDirection;
      if (scrollDirection != ScrollDirection.idle) {
        double scrollEnd =
            super.offset + (scrollDirection == ScrollDirection.reverse ? extraScrollSpeed : -extraScrollSpeed);
        scrollEnd = min(super.position.maxScrollExtent, max(super.position.minScrollExtent, scrollEnd));
        jumpTo(scrollEnd);
      }
    });
  }
}

class CodeEditorPage extends StatefulWidget {
  const CodeEditorPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CodeEditorPageState();
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
          Opacity(
            opacity: 0.0,
            child: DynamicWidgetJsonExportor(
              key: key,
              child: MyListItemExport().genExport(),
            ),
          ),
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
