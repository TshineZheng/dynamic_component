import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart' hide log;
import 'package:dynamic_component/dynamic_component.dart';
import 'package:source_gen/source_gen.dart';

import 'config.dart';
import 'log.dart';

class DynamicComponentGenerator extends GeneratorForAnnotation<Variables> {
  final Config config;

  DynamicComponentGenerator(this.config) {
    log_debug = config.debug;
  }

  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    // 仅处理注解 EventAuto 的类
    if (element is! Variables) {
      throw InvalidGenerationSourceError('EventAuto class is not ok for ${element.displayName}');
    }

    final clazz = element;

    log('processing class ${clazz.name}');
  }
}
