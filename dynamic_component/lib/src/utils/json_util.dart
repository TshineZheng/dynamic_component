class JsonUtil {
  JsonUtil._();

  static dynamic jsonGet(dynamic json, String code) {
    if (json == null) return null;
    
    int firstDotIndex = code.indexOf('.');
    if (firstDotIndex == -1) {
      if (isNumeric(code)) {
        final index = int.tryParse(code);
        if (index == null) return null;
        return json[index];
      }
      return json[code];
    }

    final firstKey = code.substring(0, firstDotIndex);
    final leaveKey = code.substring(firstDotIndex + 1);

    if (isNumeric(firstKey)) {
      final index = int.tryParse(firstKey);
      if (index == null) return null;
      return jsonGet(json[index], leaveKey);
    }

    return jsonGet(json[firstKey], leaveKey);
  }

  static bool isNumeric(String s) {
    return int.tryParse(s) != null;
  }
}
