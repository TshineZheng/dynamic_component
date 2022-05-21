import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/config.dart';
import 'src/dynamic_component_generator.dart';

Builder dynamicComponentCodegen(BuilderOptions options) {
  return SharedPartBuilder([
    DynamicComponentGenerator(
      Config(
        debug: options.config['debug'] ?? false,
      ),
    ),
  ], 'dynamic_component_codegen');
}
