// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dynamic_component/dynamic_component.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:example/util/widget_json.dart';
import 'package:example/widget/flexible_parser.dart';
import 'package:example/widget/image_widget.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'model/goods.dart';
import 'page/code_edit_page.dart';
import 'util/fake_data.dart';
import 'widget/my_list_item.dart';

void main() async {
  DynamicWidgetBuilder.addParser(FlexibleParser());
  DynamicWidgetBuilder.addParser(ImageWidgetParser());

  await initDSLCache();

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
    final rng = Random();
    Iterable l = json.decode(goodsData);
    goodsList = List<Goods>.from(l.map((model) => Goods.fromJson(model)).map((e) => e.copyWith(
          goodsImage: Faker.instance.image.loremPicsum.image(seed: e.goodsName),
          type: rng.nextInt(4),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          controller: kIsWeb
              ? null
              : Platform.isWindows
                  ? AdjustableScrollController(80)
                  : null,
          child: MasonryGridView.count(
            // 展示几列
            crossAxisCount: max(MediaQuery.of(context).size.width ~/ 240, 1),
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
            heroTag: 1,
            onPressed: () => CodeEditorPage.push(context, MyListItem.export()),
            tooltip: 'export dsl',
            child: const Text('Export'),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 2,
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
