// ignore_for_file: unnecessary_brace_in_string_interps

String tempCode({
  required String widgetNameCamelCase,
  required String dataRelation,
  required String dataForExport,
  required String widgetName,
  required String variablesDim,
  required String variablesSet,
}) {
  return """
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

  @override
  String get widgetType => '${widgetName}';

  @override
  Map<String, dynamic>? get dataRelation => {
    ${dataRelation}
  };
}
""";
}
