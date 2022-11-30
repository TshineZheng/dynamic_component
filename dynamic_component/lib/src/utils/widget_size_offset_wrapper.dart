
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class WidgetSizeOffsetWrapper extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onSizeChange;

  const WidgetSizeOffsetWrapper({
    Key? key,
    required this.onSizeChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WidgetSizeRenderObject(onSizeChange);
  }
}

class WidgetSizeRenderObject extends RenderProxyBox {
  final OnWidgetSizeChange onSizeChange;
  Size? currentSize;

  WidgetSizeRenderObject(this.onSizeChange);

  @override
  void performLayout() {
    super.performLayout();

    try {
      Size? newSize = child?.size;

      if (newSize != null && currentSize != newSize) {
        currentSize = newSize;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onSizeChange(newSize);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}