// ignore_for_file: unnecessary_brace_in_string_interps

String tempCode({
  required String widgetNameCamelCase,
  required String dataRelation,
  required String dataForExport,
  required String widgetName,
  required String variablesDim,
  required String variablesSet,
  required String exportClassName,
}) {
  return """
const _${widgetNameCamelCase}DataRelation = {
  ${dataRelation}
};

const _${widgetNameCamelCase}DataForExport = {
  ${dataForExport}
};

mixin _\$${widgetName}Component on DynamicComponent {
  ${variablesDim}

  void _setVariables() {
    ${variablesSet}
  }

  @override
  Widget localBuild(BuildContext context) {
    _setVariables();
    return super.localBuild(context);
  }
}

mixin _\$${exportClassName} on DynamicComponentExportMixin {
  @override
  String get widgetName => '${widgetName}';

  @override
  Type get widgetType => ${exportClassName};

  @override
  Map<String, String>? get dataRelation => _${widgetNameCamelCase}DataRelation;
}
""";
}
