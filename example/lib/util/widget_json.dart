import 'package:dynamic_component/dynamic_component.dart';

Map<String, DSLInfo> widgetsCache = {};

DSLInfo? getWidgetDSLInfo(String name) {
  return widgetsCache[name];
}

void initDSLCache() {
  final a = DSLInfo.fromDSL(_dslJson);
  widgetsCache[a.type] = a;
}

const _dslJson = '''
{
        "type": "MyListItem",
        "dataRelation": {
            "#title#": "goods_name",
            "#content#": "goods_detail",
            "#image#": "goods_image",
            "#isliked#": "isliked"
        },
        "child": {
            "type": "Container",
            "alignment": null,
            "padding": "8.0,8.0,8.0,8.0",
            "color": null,
            "margin": null,
            "constraints": null,
            "child": {
                "type": "Row",
                "crossAxisAlignment": "start",
                "mainAxisAlignment": "start",
                "mainAxisSize": "max",
                "textBaseline": "ideographic",
                "textDirection": null,
                "verticalDirection": "down",
                "children": [
                    {
                        "type": "Stack",
                        "alignment": "topLeft",
                        "textDirection": "ltr",
                        "fit": "loose",
                        "clipBehavior": "hardEdge",
                        "children": [
                            {
                                "type": "TapDetctor",
                                "event": "image",
                                "child": {
                                    "type": "SizedBox",
                                    "width": 100,
                                    "height": 100,
                                    "child": {
                                        "type": "NetworkImage",
                                        "src": "#image#",
                                        "semanticLabel": null,
                                        "excludeFromSemantics": false,
                                        "width": null,
                                        "height": null,
                                        "color": null,
                                        "colorBlendMode": null,
                                        "fit": "fitHeight",
                                        "alignment": "center",
                                        "repeat": "noRepeat",
                                        "centerSlice": null,
                                        "matchTextDirection": false,
                                        "gaplessPlayback": false,
                                        "filterQuality": "low"
                                    }
                                }
                            },
                            {
                                "type": "Positioned",
                                "top": null,
                                "right": 0,
                                "bottom": 0,
                                "left": null,
                                "width": null,
                                "height": null,
                                "child": {
                                    "type": "TapDetctor",
                                    "event": "like",
                                    "child": {
                                        "type": "IfOrNot",
                                        "actual": "#isliked#",
                                        "expect": "false",
                                        "matched": {
                                            "type": "Text",
                                            "data": "♡",
                                            "textAlign": "start",
                                            "overflow": null,
                                            "maxLines": null,
                                            "semanticsLabel": null,
                                            "softWrap": null,
                                            "textDirection": "ltr",
                                            "style": {
                                                "color": "fff44336",
                                                "debugLabel": null,
                                                "decoration": "none",
                                                "fontSize": 30,
                                                "fontFamily": null,
                                                "fontStyle": "normal",
                                                "fontWeight": "normal"
                                            },
                                            "textScaleFactor": null
                                        },
                                        "failed": {
                                            "type": "Text",
                                            "data": "♥",
                                            "textAlign": "start",
                                            "overflow": null,
                                            "maxLines": null,
                                            "semanticsLabel": null,
                                            "softWrap": null,
                                            "textDirection": "ltr",
                                            "style": {
                                                "color": "fff44336",
                                                "debugLabel": null,
                                                "decoration": "none",
                                                "fontSize": 30,
                                                "fontFamily": null,
                                                "fontStyle": "normal",
                                                "fontWeight": "normal"
                                            },
                                            "textScaleFactor": null
                                        }
                                    }
                                }
                            }
                        ]
                    },
                    {
                        "type": "SizedBox",
                        "width": 20,
                        "height": null,
                        "child": null
                    },
                    {
                        "type": "Flexible",
                        "flex": 1,
                        "child": {
                            "type": "Column",
                            "crossAxisAlignment": "start",
                            "mainAxisAlignment": "start",
                            "mainAxisSize": "max",
                            "textBaseline": "ideographic",
                            "textDirection": null,
                            "verticalDirection": "down",
                            "children": [
                                {
                                    "type": "TapDetctor",
                                    "event": "title",
                                    "child": {
                                        "type": "Text",
                                        "data": "#title#",
                                        "textAlign": "start",
                                        "overflow": null,
                                        "maxLines": 1,
                                        "semanticsLabel": null,
                                        "softWrap": null,
                                        "textDirection": "ltr",
                                        "style": {
                                            "color": null,
                                            "debugLabel": null,
                                            "decoration": "none",
                                            "fontSize": 24,
                                            "fontFamily": null,
                                            "fontStyle": "normal",
                                            "fontWeight": "normal"
                                        },
                                        "textScaleFactor": null
                                    }
                                },
                                {
                                    "type": "SizedBox",
                                    "width": null,
                                    "height": 10,
                                    "child": null
                                },
                                {
                                    "type": "Row",
                                    "crossAxisAlignment": "center",
                                    "mainAxisAlignment": "start",
                                    "mainAxisSize": "max",
                                    "textBaseline": "ideographic",
                                    "textDirection": null,
                                    "verticalDirection": "down",
                                    "children": [
                                        {
                                            "type": "Expanded",
                                            "flex": 1,
                                            "child": {
                                                "type": "TapDetctor",
                                                "event": "content",
                                                "child": {
                                                    "type": "Text",
                                                    "data": "#content#",
                                                    "textAlign": "start",
                                                    "overflow": "ellipsis",
                                                    "maxLines": 6,
                                                    "semanticsLabel": null,
                                                    "softWrap": null,
                                                    "textDirection": "ltr",
                                                    "style": null,
                                                    "textScaleFactor": null
                                                }
                                            }
                                        }
                                    ]
                                }
                            ]
                        }
                    }
                ]
            }
        }
    }
''';
