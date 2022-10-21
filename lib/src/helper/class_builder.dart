import 'package:analyzer/dart/element/type.dart';

class ClassBuilderFactory {
  late final StringBuffer _buf;
  late final String _className;
  final Map<String, DartType> _fields = {};

  ClassBuilderFactory({required String className, StringBuffer? buffer})
      : _buf = buffer ?? StringBuffer(),
        _className = className;

  void addFields(Map<String, DartType> fields, {required String prefix}) {
    final modifiedFields = fields.map((fieldName, fieldType) {
      final modKey = _modifyKey(prefix, fieldName, _isPrivate(fieldName));
      return MapEntry(modKey, fieldType);
    });

    _fields.addAll(modifiedFields);
  }

  String build() {
    _buf.writeln('class $_className {');
    _buildFields();
    _buildConstructor();
    _buf.writeln('}');
    return _buf.toString();
  }

  bool _isPrivate(String key) {
    return key.startsWith('_');
  }

  String _modifyKey(final prefix, String key, bool isPrivate) {
    String tmpKey = key;
    if (isPrivate) {
      tmpKey = tmpKey.substring(1);
    }
    tmpKey = prefix + _capitalize(tmpKey);
    if (isPrivate) {
      tmpKey = '_$tmpKey';
    }
    return tmpKey;
  }

  String _capitalize(String key) {
    if (key.isEmpty) return key;
    return key[0].toUpperCase() + key.substring(1);
  }

  void _buildFields() {
    for (var field in _fields.entries) {
      _buf.writeln('final ${field.value} ${field.key};');
    }
  }

  void _buildConstructor() {
    _buf.writeln('$_className(');
    for (var field in _fields.keys) {
      _buf.writeln('this.$field,');
    }
    _buf.writeln(');');
  }
}
