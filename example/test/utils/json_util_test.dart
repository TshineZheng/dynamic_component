import 'package:dynamic_component/src/utils/json_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JsonUtil', () {
    test('jsonGet', () {
      Map map = {
        'a': 1,
        'b': 2,
        'c': 3,
        'obj': {
          'aa': 11,
          'bb': 22,
          'cc': 33,
          'array': [
            {
              's1': 101,
              "s2": 102,
            },
            {
              's1': 201,
              "s2": 202,
            },
            [
              {
                's1': 101,
                "s2": 102,
              },
              {
                's1': 2010,
                "s2": 2020,
              }
            ],
          ],
        },
        'array': [
          {
            's1': 101,
            "s2": 102,
          },
          {
            's1': 201,
            "s2": 202,
          }
        ]
      };

      expect(JsonUtil.jsonGet(map, 'a'), equals(1));
      expect(JsonUtil.jsonGet(map, 'obj.bb'), equals(22));
      expect(JsonUtil.jsonGet(map, 'array.0.s1'), equals(101));
      expect(JsonUtil.jsonGet(map, 'obj.array.1.s1'), equals(201));
      expect(JsonUtil.jsonGet(map, 'obj.array.2.1.s1'), equals(2010));
    });
  });
}
