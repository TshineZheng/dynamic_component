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
    final varsDSlValue = vars.map((e) => DSLValue.fromDSLKeyword(e)).toList();

    final widgetName = clazz.name;
    final widgetNameCamelCase = widgetName.camelCase;

    final dataRelation = StringBuffer();
    final dataForExport = StringBuffer();
    final variablesDim = StringBuffer();
    final variablesSet = StringBuffer();

    for (var i = 0; i < vars.length; i++) {
      dataRelation.writeln('"${genDataRelationKey(varsDSlValue[i])}" : "${varsDSlValue[i].dataName}",');
      dataForExport.writeln('"${varsDSlValue[i].dataName}" : ${genDataForExportValue(varsDSlValue[i])},');
      variablesDim.writeln('late final ${genDimType(varsDSlValue[i])} ${varsDSlValue[i].dataName.camelCase};');
      variablesSet.writeln('${varsDSlValue[i].dataName.camelCase} = ${genSetValue(varsDSlValue[i])}');
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

  String genDataRelationKey(DSLValue value) {
    if (value.value is String) {
      return '#${value.dataName}#';
    }
    return value.toDSLKeyword();
  }

  String genDataForExportValue(DSLValue value) {
    if (value.value is bool) {
      return 'false';
    } else if (value.value is int) {
      return '0';
    } else if (value.value is double) {
      return '0.0';
    } else {
      return '"#${value.dataName}#"';
    }
  }

  String genDimType(DSLValue value) {
    if (value.value is String) {
      return 'String';
    }
    return 'DSLValue<${value.value.runtimeType.toString()}>';
  }

  String genSetValue(DSLValue value) {
    if (value.value is bool) {
      return 'DSLValue(value: data?["${value.dataName}"] ?? false, dataName: "${value.dataName}");';
    } else if (value.value is int) {
      return 'DSLValue(value: data?["${value.dataName}"] ?? 0, dataName: "${value.dataName}");';
    } else if (value.value is double) {
      return 'DSLValue(value: data?["${value.dataName}"] ?? 0.0, dataName: "${value.dataName}");';
    } else {
      return 'data?["${value.dataName}"]?.toString() ?? "";';
    }
  }
}
