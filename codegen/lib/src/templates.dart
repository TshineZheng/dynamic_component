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

mixin _\$${widgetName}Component on DynamicComponent {
  ${variablesDim}

  void _setVariables() {
    ${variablesSet}
  }

  void _setVariables4Export() {
    ${dataForExport}
  }

  @override
  Widget localBuild(BuildContext context) {
    if(null != data){
      _setVariables();
    }else{
      _setVariables4Export();
    }
    
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
