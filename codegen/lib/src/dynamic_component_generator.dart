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

    final vars = annotation.read('variables').listValue.map((e) => e.toStringValue()!).toList();
    final varsCamelCase = vars.map((e) => e.camelCase).toList();

    final widgetName = clazz.name;
    final widgetNameCamelCase = widgetName.camelCase;

    final dataRelation = StringBuffer();
    final dataForExport = StringBuffer();
    final variablesDim = StringBuffer();
    final variablesSet = StringBuffer();

    for (var i = 0; i < vars.length; i++) {
      dataRelation.writeln('"#${varsCamelCase[i]}#" : "${vars[i]}",');
      dataForExport.writeln('"${vars[i]}" : "#${varsCamelCase[i]}#",');
      variablesDim.writeln('late final String ${varsCamelCase[i]};');
      variablesSet.writeln('${varsCamelCase[i]} = data?["${vars[i]}"]?.toString() ?? "";');
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
