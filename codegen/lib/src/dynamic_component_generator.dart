import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart' hide log;
import 'package:dynamic_component/foundation.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

import 'config.dart';
import 'log.dart';
import 'templates.dart';

class DynamicComponentGenerator extends GeneratorForAnnotation<Component> {
  final Config config;

  DynamicComponentGenerator(this.config) {
    log_debug = config.debug;
  }

  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    // 仅处理类上的注解
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError('@Component annotation is not ok for ${element.displayName}.');
    }

    if (element.supertype?.element.displayName != 'DynamicComponent') {
      throw InvalidGenerationSourceError(
          'Classes that use the @Component annotation must be extends DynamicComponent. Affected classes: ${element.displayName}.');
    }

    final clazz = element;

    final varDims = annotation.read('variables').listValue.map((e) => e.toStringValue()!).toList();

    //TODO: 需要对 [varDims] 做合法验证

    final varsNameCamelCase = varDims.map((e) => e.replaceAll('[', '').replaceAll(']', '').camelCase).toList();

    final widgetName = clazz.name;
    final widgetNameCamelCase = widgetName.camelCase;

    final dataRelation = StringBuffer();
    final dataForExport = StringBuffer();
    final variablesDim = StringBuffer();
    final variablesSet = StringBuffer();

    for (var i = 0; i < varDims.length; i++) {
      dataRelation.writeln('\'#${varsNameCamelCase[i]}#\' : \'${varDims[i]}\',');
      dataForExport.writeln('${varsNameCamelCase[i]} = \'#${varsNameCamelCase[i]}#\';');
      variablesDim.writeln('late final String ${varsNameCamelCase[i]};');
      variablesSet.writeln('${varsNameCamelCase[i]} = JsonUtil.jsonGet(data,"${varDims[i]}")?.toString() ?? "";');
    }

    return tempCode(
      dataForExport: dataForExport.toString(),
      dataRelation: dataRelation.toString(),
      variablesDim: variablesDim.toString(),
      variablesSet: variablesSet.toString(),
      widgetName: widgetName,
      widgetNameCamelCase: widgetNameCamelCase,
    );
  }
}
