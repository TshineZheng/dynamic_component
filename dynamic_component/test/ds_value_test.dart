import 'package:dynamic_component/src/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DSLValue bool', () {
    const dslValueStr = '@bool:boolVar';
    final dslValue = DSLValue<bool>(value: true, name: 'boolVar');

    test('toDSLString', () {
      expect(dslValue.toDSLString(), equals(dslValueStr));
    });

    test('fromDSLString', (() {
      final dslValue = DSLValue.fromDSLString(dslValueStr);
      expect(dslValue.toDSLString(), equals(dslValueStr));
    }));

    test('inject', () {
      final t = dslValue.inject(data: true, dsl: dslValueStr);
      expect(t, equals('true'));
    });
  });

  group('DSLValue String', () {
    const dslValueStr = 'stringVar';
    final dslValue = 'stringVar'.toValue();

    test('toDSLString', () {
      expect(dslValue.toDSLString(), equals(dslValueStr));
    });

    test('fromDSLString', (() {
      final dslValue = DSLValue.fromDSLString(dslValueStr);
      expect(dslValue.toDSLString(), equals(dslValueStr));
    }));

    test('inject', () {
      final t = dslValue.inject(data: 'hello', dsl: dslValueStr);
      expect(t, equals('hello'));
    });
  });

  group('DSLValue int', () {
    const dslValueStr = '@int:intVar';
    final dslValue = DSLValue<int>(value: 1, name: 'intVar');

    test('toDSLString', () {
      expect(dslValue.toDSLString(), equals(dslValueStr));
    });

    test('fromDSLString', (() {
      final dslValue = DSLValue.fromDSLString(dslValueStr);
      expect(dslValue.toDSLString(), equals(dslValueStr));
    }));

    test('inject', () {
      final t = dslValue.inject(data: 1, dsl: dslValueStr);
      expect(t, equals('1'));
    });
  });

  group('DSLValue double', () {
    const dslValueStr = '@double:doubleVar';
    final dslValue = DSLValue<double>(value: 1.0, name: 'doubleVar');

    test('toDSLString', () {
      expect(dslValue.toDSLString(), equals(dslValueStr));
    });

    test('fromDSLString', (() {
      final dslValue = DSLValue.fromDSLString(dslValueStr);
      expect(dslValue.toDSLString(), equals(dslValueStr));
    }));

    test('inject', () {
      final t = dslValue.inject(data: 1.0, dsl: dslValueStr);
      expect(t, equals('1.0'));
    });
  });
}
