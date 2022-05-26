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
  final String name;

  DSLValue({required this.value, required this.name})
      : assert(T == int || T == double || T == bool || T == String,
            "DSValue Generics Type must be int or double or bool or String, but find $T");

  String toDSLString() {
    if (T == String) {
      return name.toString();
    } else {
      return '@${value.runtimeType}:$name'; // "@int:name"
    }
  }

  String inject({required T data, required String dsl}) {
    return dsl.replaceAll(toDSLString(), data.toString());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DSLValue<T> && runtimeType == other.runtimeType && value == other.value && name == other.name;

  @override
  int get hashCode => value.hashCode ^ name.hashCode;

  static DSLValue fromDSLString(String str) {
    if (str.startsWith('@int:')) {
      final name = str.replaceAll('@int:', '').trim();
      return DSLValue<int>(value: 0, name: name);
    } else if (str.startsWith('@double:')) {
      final name = str.replaceAll('@double:', '').trim();
      return DSLValue<double>(value: 0, name: name);
    } else if (str.startsWith('@bool:')) {
      final name = str.replaceAll('@bool:', '').trim();
      return DSLValue<bool>(value: false, name: name);
    } else {
      return DSLValue<String>(value: str, name: str);
    }
  }
}

extension IntValueExt on int {
  DSLValue<int> toValue(String name) => DSLValue<int>(value: this, name: name);
}

extension DoubleValueExt on double {
  DSLValue<double> toValue(String name) => DSLValue<double>(value: this, name: name);
}

extension BoolValueExt on bool {
  DSLValue<bool> toValue(String name) => DSLValue<bool>(value: this, name: name);
}

extension StringValueExt on String {
  DSLValue<String> toValue() => DSLValue<String>(value: this, name: this);
}
