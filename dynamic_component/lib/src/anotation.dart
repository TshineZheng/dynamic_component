class Component {
  /// 部件会用到的变量，对应 [DynamicComponent.data] 的 key 值。
  ///
  /// 会自动创建对应的变量，提供在 [DynamicComponent.buildWidget] 中直接使用。
  final List<String>? variables;

  /// 创建一个部件，只能注解在类上，且必须继承 [DynamicComponent] 来实现。
  const Component({this.variables});
}
