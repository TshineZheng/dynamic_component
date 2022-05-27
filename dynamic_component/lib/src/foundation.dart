class Component {
  /// 部件会用到的变量，对应 [DynamicComponent.data] 的 key 值。
  ///
  /// 会自动创建对应的变量，提供在 [DynamicComponent.buildWidget] 中直接使用。
  final List<String>? variables;

  /// 创建一个部件，只能注解在类上，且必须继承 [DynamicComponent] 来实现。
  const Component({this.variables});
}

class DSLValue<T> {
  final T value;
  final String dataName;

  DSLValue({required this.value, required this.dataName})
      : assert(T == int || T == double || T == bool || T == String,
            "DSValue Generics Type must be int or double or bool or String, but find $T");

  String toDSLKeyword() {
    if (T == String) {
      return dataName.toString();
    } else {
      return '@${value.runtimeType}:$dataName'; // "@int:name"
    }
  }

  String inject({required T data, required String dsl}) {
    if (data == null) {
      return dsl;
    }

    final dslKeyWord = toDSLKeyword();

    if (T == String) {
      return dsl.replaceAll(dslKeyWord, data.toString());
    } else {
      // 如果不是字符串,会默认将两边的双引号也给替换掉
      return dsl.replaceAll('"$dslKeyWord"', data.toString());
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DSLValue<T> && runtimeType == other.runtimeType && value == other.value && dataName == other.dataName;

  @override
  int get hashCode => value.hashCode ^ dataName.hashCode;

  static DSLValue fromDSLKeyword(String str) {
    if (str.startsWith('@int:')) {
      final name = str.replaceAll('@int:', '').trim();
      return DSLValue<int>(value: 0, dataName: name);
    } else if (str.startsWith('@double:')) {
      final name = str.replaceAll('@double:', '').trim();
      return DSLValue<double>(value: 0, dataName: name);
    } else if (str.startsWith('@bool:')) {
      final name = str.replaceAll('@bool:', '').trim();
      return DSLValue<bool>(value: false, dataName: name);
    } else {
      return DSLValue<String>(value: str, dataName: str);
    }
  }

  static DSLValue fromValue(dynamic value, {String? name}) {
    if (value is bool || value is bool?) {
      return DSLValue<bool>(value: value ?? false, dataName: name ?? DateTime.now().microsecondsSinceEpoch.toString());
    } else if (value is int || value is int?) {
      return DSLValue<int>(value: value ?? 0, dataName: name ?? DateTime.now().microsecondsSinceEpoch.toString());
    } else if (value is double || value is double?) {
      return DSLValue<double>(value: value ?? 0.0, dataName: name ?? DateTime.now().microsecondsSinceEpoch.toString());
    } else {
      return DSLValue<String>(
          value: value?.toString() ?? '', dataName: name ?? DateTime.now().microsecondsSinceEpoch.toString());
    }
  }
}

extension IntValueExt on int {
  DSLValue<int> toDSLValue(String name) => DSLValue<int>(value: this, dataName: name);
}

extension DoubleValueExt on double {
  DSLValue<double> toDSLValue(String name) => DSLValue<double>(value: this, dataName: name);
}

extension BoolValueExt on bool {
  DSLValue<bool> toDSLValue(String name) => DSLValue<bool>(value: this, dataName: name);
}

extension StringValueExt on String {
  DSLValue<String> toDSLValue({String? name}) => DSLValue<String>(value: this, dataName: name ?? this);
}
